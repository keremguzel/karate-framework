package feature;

import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import org.junit.Test;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collection;
import java.util.List;

import static java.lang.Integer.parseInt;
import static org.junit.Assert.assertEquals;


public class TestParallel {

    @Test
    public void testParallel() {
        String threadCount = System.getProperty("count");
        List<String> tagList = Arrays.asList("~@excluded", "~wip");
        int count = (threadCount == null) ? 5 : parseInt(threadCount);
        Results results = Runner.path("classpath:feature").tags(tagList).outputCucumberJson(true).parallel(count);
        generateReport(results.getReportDir());
        assertEquals(results.getErrorMessages(), 0, results.getFailCount());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Karate Project");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }

}

