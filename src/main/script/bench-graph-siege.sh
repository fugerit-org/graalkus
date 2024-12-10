#!/usr/bin/env bash
#
# Simple benchmark script using siege and psrecord
#
# Author:	Matteo Franci <mttfranci@gmail.com>
#
# to run this script :
# - clone project : https://github.com/fugerit-org/graalkus
# - from the project root : 'mvn clean package' (requires jdk 21)
# - run : ./src/main/script/bench-graph-siege.sh -m JIT
#
# NOTE: this script is inspired by <https://github.com/alina-yur/native-spring-boot/blob/main/bench-jit-c2.sh>
set -e

function print() {
    printf "\033[1;34m$1\033[0m\n"
}

# Main entry point
main() {

  # check if siege is installed
  if [ ! -x "$(command -v siege)" ]; then
    echo "Missing siege, please install it"
    echo "On MacOS : brew install siege"
    echo "On Ubuntu/Debian based : apt install siege"
    echo "On Fedora/RPM based : dnf install siege"
    echo "For more info : https://github.com/JoeDog/siege"
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

  URL_PARAM_FILE=${BASE_DIR}/url_${OUTPUT_BASE}.txt

  # Split the string into an array using the IFS variable
  IFS=' ' read -ra array <<< "${URL_PARAM}"

  # Print the array elements
  for url in "${array[@]}"; do
    echo "$url" >> ${URL_PARAM_FILE}
  done

  arraySize=${#array[@]}
  echo "Number of url : ${arraySize}"
  WUR=$((WARMUP_REQUESTS / arraySize))
  NOR=$((NUMBER_OF_REQUESTS / arraySize))

  echo "WUR: ${WUR} (from ${WARMUP_REQUESTS}), NOR: ${NOR} (from ${NUMBER_OF_REQUESTS})"

  print "Executing warmup load : ${WARMUP_REQUESTS}, additional options : ${H2LOAD_OPTIONS}"
  siege ${H2LOAD_OPTIONS} -r ${WUR} -c ${NUMBER_OF_CLIENTS} -f ${URL_PARAM_FILE}

  print "Executing benchmark load : ${NUMBER_OF_REQUESTS}, additional options : ${H2LOAD_OPTIONS}"
  siege ${H2LOAD_OPTIONS} -r ${NOR} -c ${NUMBER_OF_CLIENTS} -f ${URL_PARAM_FILE} > ${BASE_DIR}/out_${OUTPUT_BASE}.log 2>&1


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