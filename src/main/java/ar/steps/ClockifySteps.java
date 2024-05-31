package ar.steps;

import io.cucumber.java.en.And;
import io.cucumber.java.en.Given;
import io.lippia.api.lowcode.configuration.ConfigurationType;

import java.time.Instant;

import static io.lippia.api.lowcode.variables.VariablesManager.setVariable;

public class ClockifySteps {

    @And("^define unique (.*)")
    public void setRandomName(String key) {
        String uniqueName = "Project" + Instant.now().getEpochSecond();
        setVariable(key, uniqueName);
    }
}
