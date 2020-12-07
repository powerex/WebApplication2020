package example.cucumber;

import io.cucumber.java.en.Given;
import io.cucumber.java.en.Then;
import io.cucumber.java.en.When;
import io.cucumber.junit.Cucumber;
import org.junit.runner.RunWith;

import static org.junit.Assert.assertEquals;

public class CucumberSteps {

    private int a;
    private int b;
    private int calc;
    private int sub;

    @Given("^the numbers (.*) and (.*)$")
    public void captureNumbers(final int a, final int b) {
        this.a = a;
        this.b = b;
    }

    @When("^the numbers are added together$")
    public void addNumbers() {
        this.calc = a + b;
    }

    @When("^the numbers are subtracts$")
    public void subNumbers() {
        this.sub = a / b;
    }

    @Then("^the result is (.*)$")
    public void assertResult(final int expectedResult) {
        assertEquals(expectedResult, calc);
    }

    @Then("^the sub is (.*)$")
    public void assertSub(final int expectedResult) {
        assertEquals(expectedResult, sub);
    }

    @RunWith(Cucumber.class)
    public class CucumberRunner {}
}
