#!/usr/bin/env bash
#
# Simple benchmark script using h2load and psrecord
#
# Author:	Matteo Franci <mttfranci@gmail.com>
#
# to run this script :
# - clone project : https://github.com/fugerit-org/graalkus
# - from the project root : 'mvn clean package' (requires jdk 21)
# - run : ./src/main/script/bench-graph-h2-load.sh JIT
#
# NOTE: this script is inspired by <https://github.com/alina-yur/native-spring-boot/blob/main/bench-jit-c2.sh>
set -e

function print() {
    printf "\033[1;34m$1\033[0m\n"
}

# Help for this script
help() {

	cat <<HERE

$@

Usage: ./bench-graph-h2-load.sh.sh [options]
Options marked with * are required.

Sample usage :
./bench-graph-h2-load.sh.sh

Options:
--urlbase, -u
  Base benchmark url (default : 'http://localhost:8080'
--requests, -r
  Total number of requests (default : 250000)
--clients, -c
  Total number of clients (default : 12)
--threads, -t
  Total number of threads per client (default : 1)
--basedir, -b
  Base output dir (default : './target')
  NOTE: output of the benchmark can be found in this folder
--warmup, -w
  Total number of warmup requests (default : 50000)
--mode, -m
  Running mode, (default : "")
  if values is "JIT" will search for a 'quarkus-app/quarkus-run.jar' har in the base dir an run it trying to plot the process
  if values is "AOT" will search for a 'graalkus*runner' executable in the base dir an run it trying to plot the process
  any other values, it will except the application to be already running
--application, -a
  application pattern override for JIT or AOT mode. (for instance 'graalkus*optimized*runner' instead of 'graalkus*runner')
--pdf, -p
  normally benchmark will run only on feature supported by both AOT and JIT application.
  As AOT application currently does not support 'pdf' output, this flag will enable running 'pdf' request too.
  NOTE: so running it on pure AOT application, will lead to some failures.
--options, -o
  additional parameters to pass to h2load
--help, -h
	Show this help
HERE
	exit 1
}

# Main entry point
main() {

  # check if h2load is installed
  if [ ! -x "$(command -v h2load)" ]; then
    echo "Missing h2load, please install nghttp2"
    echo "On MacOS : brew install nghttp2"
    echo "On Ubuntu/Debian based : apt-get install nghttp2-client"
    echo "On Fedora/RPM based : dnf install nghttp2"
    echo "For more info : https://nghttp2.org/documentation/package_README.html"
    exit 1
  fi

  if [[ "${TYPE}" = "" ]]; then
    export NO_START=1
  fi

  export URL_BASE=${URL_BASE:-http://localhost:8080}
  export NUMBER_OF_REQUESTS=${NUMBER_OF_REQUESTS:-250000}
  export NUMBER_OF_CLIENTS=${NUMBER_OF_CLIENTS:-12}
  export NUMBER_OF_THREADS=${NUMBER_OF_THREADS:-1}
  export BASE_DIR=target
  export WARMUP_REQUESTS=${WARMUP_REQUESTS:-50000}
  export URL_PARAM="${URL_BASE}/doc/example.html ${URL_BASE}/doc/example.html ${URL_BASE}/doc/example.html ${URL_BASE}/doc/example.html ${URL_BASE}/doc/example.md ${URL_BASE}/doc/example.md ${URL_BASE}/doc/example.md ${URL_BASE}/doc/example.adoc ${URL_BASE}/doc/example.adoc"

  if [[ "${PDF}" = "1" ]]; then
    export URL_PARAM="${URL_PARAM} ${URL_BASE}/doc/example.pdf"
    echo "added pdf url : ${URL_PARAM}"
  fi

  export OUTPUT_BASE=$(date +%Y%m%d%H%M%S)_${TYPE:-GEN}

  # check if quarkus-run.jar exists
 if [[ "${TYPE}" = "JIT" ]]; then
    if [ ! -f ./${BASE_DIR}/quarkus-app/quarkus-run.jar ]; then
      echo "Missing quarkus-run.jar, please run 'mvn clean package' first"
      exit 2
    fi
 fi

  if [[ "${TYPE}" = "AOT" ]]; then
     if [ ! -f ./${BASE_DIR}/graalkus*runner ]; then
       echo "Missing runner executable please run 'mvn install -Dnative' first"
       exit 2
     fi
  fi

  # check if quarkus app is running
  if [ "${NO_START}" = "1" ]; then
    echo "NO_START flag = 1, assuming quarkus is already started"
  elif [ -n "$(lsof -tiTCP:8080 -sTCP:LISTEN | xargs -r ps -p | grep java | awk '{print $1}')" ]; then
    echo "It seems that Quarkus app is already running, please stop it first"
    echo "TCP ports in use :"
    lsof -tiTCP:8080 -sTCP:LISTEN | xargs -r ps -p | grep java
    echo "To stop the app : kill -9 $(lsof -tiTCP:8080 -sTCP:LISTEN | xargs -r ps -p | grep java | awk '{print $1}')"
    exit 3
  fi

  echo "Running with arguments : NUMBER_OF_REQUESTS=${NUMBER_OF_REQUESTS}, NUMBER_OF_CLIENTS=${NUMBER_OF_CLIENTS}, URL_PARAM=${URL_PARAM}"

  print "Starting the app 🏎️"

  if [ "${NO_START}" != "1" ]; then
    if [[ "${TYPE}" = "JIT" ]]; then
      EXEC=${APPLICATION:-quarkus-app/quarkus-run.jar}
      echo "Starting JIT application : ${EXEC}"
      java -Xmx1024m -jar ./${BASE_DIR}/${EXEC} &
    else
      if [[ "${TYPE}" = "AOT" ]]; then
        EXEC=${APPLICATION:-graalkus*runner}
        echo "Starting AOT application : ${EXEC}"
        ./${BASE_DIR}/${EXEC} &
      fi
    fi
    export PID=$!
    sleep 8
    print "Done waiting for startup..."
    if [ -x "$(command -v psrecord)" ]; then
      echo "psrecord installed, plotting process : ${PID}"
      psrecord $PID --plot "${BASE_DIR}/out_${OUTPUT_BASE}.png" --include-children &
    else
      echo "psrecord not installed, plotting skipped for process : ${PID}"
    fi
  fi

  print "Executing warmup load : ${WARMUP_REQUESTS}, additional options : ${H2LOAD_OPTIONS}"
  h2load ${H2LOAD_OPTIONS} -n${WARMUP_REQUESTS} -c${NUMBER_OF_CLIENTS} -t${NUMBER_OF_THREADS} --warm-up-time=2 ${URL_PARAM}

  print "Executing benchmark load : ${NUMBER_OF_REQUESTS}, additional options : ${H2LOAD_OPTIONS}"
  h2load ${H2LOAD_OPTIONS} -n${NUMBER_OF_REQUESTS} -c${NUMBER_OF_CLIENTS} -t${NUMBER_OF_THREADS} --warm-up-time=2 ${URL_PARAM} > ${BASE_DIR}/out_${OUTPUT_BASE}.log 2>&1


  print "${TYPE} run done!🎉"

  if [ "${NO_START}" != "1" ]; then
    print "Killing process ${PID}"
    # try to kill the process
    kill $PID

    # Check if quarkus app is still running
    # wait 5 seconds
    sleep 5

    PID_TO_KILL="$(lsof -tiTCP:8080 -sTCP:LISTEN | xargs -r ps -p | grep java | awk '{print $1}')"
    if [[ -n  ${PID_TO_KILL} ]]; then
      echo "Quarkus app is still running, killing it"
      kill -9 "${PID_TO_KILL}"
    fi
  fi

  print "The benchmark results are in ${BASE_DIR} folder"
  sleep 1

  exit ${?}
}


# Read command line arguments

POSITIONAL_ARGS=()

while [[ "$#" -gt 0 ]]; do
	case $1 in
	-u | urlbase)
		URL_BASE="$2"
		shift # past argument
    shift # past value
		;;
	-r | --requests)
		NUMBER_OF_REQUESTS="$2"
		shift # past argument
    shift # past value
		;;
	-c | --clients)
		NUMBER_OF_CLIENTS="$2"
		shift # past argument
    shift # past value
		;;
	-t | --threads)
		NUMBER_OF_THREADS="$2"
		shift # past argument
    shift # past value
		;;
	-b | --basedir)
		BASE_DIR="$2"
		shift # past argument
    shift # past value
		;;
	-w | --warmup)
		WARMUP_REQUESTS="$2"
		shift # past argument
    shift # past value
		;;
	-m | --mode)
		TYPE="$2"
		shift # past argument
    shift # past value
		;;
	-a | --application)
		APPLICATION="$2"
		shift # past argument
    shift # past value
		;;
	-p | --pdf)
		PDF="1"
		shift # past argument
		;;
	-o | --options)
		H2LOAD_OPTIONS="$2"
		shift # past argument
    shift # past value
		;;
	*)
		POSITIONAL_ARGS+=("$1") # save positional arg
		echo "Invalid parameter: $1"
		shift # past argument
		help "${@}"
		;;
	esac
done

# Run
main "${@}"