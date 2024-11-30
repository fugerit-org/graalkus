package test.org.fugerit.java.demo.graalkus;

import io.quarkus.test.junit.QuarkusTest;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.condition.DisabledInNativeImage;

import static io.restassured.RestAssured.given;

@QuarkusTest
class DocResourceTest {

    @Test
    void testMarkdown() {
        given().when().get("/doc/example.md").then().statusCode(200);
    }

    @Test
    void testHtml() {
        given().when().get("/doc/example.html").then().statusCode(200);
    }

    @Test
    void testAsciiDoc() {
        given().when().get("/doc/example.adoc").then().statusCode(200);
    }

    @Test
    @DisabledInNativeImage
    void testPdf() {
        given().when().get("/doc/example.pdf").then().statusCode(200);
    }

    @Test
    void testCsv() {
        given().when().get("/doc/example.csv").then().statusCode(200);
    }

}