package example;

import example.services.Game;
import example.services.HighScoreService;
import example.services.StubHighScoreService;
import org.junit.Test;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.NoSuchFileException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.Exchanger;
import java.util.concurrent.TimeUnit;

import static org.junit.Assert.*;

public class BestPractices {

    @Test
    public void assertionWithoutMessage() {
        final List<Integer> numbers = new ArrayList<>();
        numbers.add(1);

        assertFalse(numbers.isEmpty());
    }

    @Test
    public void assertionWithMessage() {
        final List<Integer> numbers = new ArrayList<>();
        numbers.add(1);

        assertTrue("The list is not empty", numbers.isEmpty());
    }

    @Test
    public void shouldBeNotEmpty() {
        final List<Integer> numbers = new ArrayList<>();
        numbers.add(1);

        assertTrue("The numbers list should not be empty", numbers.isEmpty());
    }

    // Expecting exceptions

    @Test(expected = NoSuchFileException.class)
    public void fileShouldBeExist() throws IOException {
        Files.size(Paths.get("/src/non-exist-file.txt"));
    }

    @Test(expected = Exception.class)
    public void runTest() throws IOException {
        final Path fileSystemFile = Paths.get("existent-file.txt");
        final Path wrongFile = Paths.get("http://example.com/wrong-file");
        final long fileSize = Files.size(fileSystemFile);
        final long netFileSize = Files.size(wrongFile);
        assertEquals(fileSize, netFileSize);
    }

    // Failing long-running test
    @Test(timeout = 1000L)
    public void serviceResponseTime() {
        Integer i = null;
        try {
            Thread.sleep(200L);
            i = 56;
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
        assertNotNull(i);
    }

    @Test
    public void manualResponseTimeCheck() throws InterruptedException {
        final HighScoreService realHighScore = new StubHighScoreService();
        final Game gameUnderTest = new Game(realHighScore);
        final CountDownLatch latch = new CountDownLatch(1);
        final List<Throwable> exceptions = new ArrayList<>();

        final Runnable highScoreRunnable = new Runnable() {
            @Override
            public void run() {
                final String highScoreDisplay = gameUnderTest.displayHighScores();
                try {
                    assertNotNull(highScoreDisplay);
                } catch (Throwable e) {
                    exceptions.add(e);
                }
                latch.countDown();
            }
        };

        new Thread(highScoreRunnable).start();
        assertTrue(latch.await(1, TimeUnit.SECONDS));

        if (!exceptions.isEmpty()) {
            fail("Exceptions thrown is different thread: " + exceptions);
        }
    }

}
