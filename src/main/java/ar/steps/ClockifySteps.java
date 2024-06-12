package ar.steps;

import com.crowdar.core.PageSteps;
import io.cucumber.java.en.And;


import java.time.Instant;

import static io.lippia.api.lowcode.variables.VariablesManager.setVariable;

public class ClockifySteps extends PageSteps {

    @And("^define unique (.*)")
    public void setRandomName(String key) {
        String uniqueName = "Description" + Instant.now().getEpochSecond();
        setVariable(key, uniqueName);
    }
}