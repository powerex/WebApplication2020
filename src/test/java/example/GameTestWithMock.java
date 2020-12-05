package example;

import example.services.Game;
import example.services.HighScoreService;
import org.junit.Test;
import org.mockito.Mockito;

import java.util.Arrays;
import java.util.List;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.mock;

public class GameTestWithMock {

    private final Game gameUnderTest;
    private final HighScoreService mockHighScoreService;

    public GameTestWithMock() {
        final List<String> firstHighScoreList = Arrays.asList(
            "Olia", "Maksim", "Sofia",  "Polina", "Vlad"
        );
        final List<String> secondHighScoreList = Arrays.asList(
                "Olia", "Elizabeth", "Sofia",  "Angelina", "Alina"
        );

        this.mockHighScoreService = mock(HighScoreService.class);

        Mockito.when(mockHighScoreService.getTopFivePlayers())
                .thenReturn(firstHighScoreList)
                .thenReturn(secondHighScoreList);

        this.gameUnderTest = new Game(mockHighScoreService);
    }

    @Test
    public void highScoreDisplay() {
        final String firstExpectedList =
                "1. Olia\n" +
                "2. Maksim\n" +
                "3. Sofia\n" +
                "4. Polina\n" +
                "5. Vlad\n";

        final String secondExpectedList =
                "1. Olia\n" +
                "2. Elizabeth\n" +
                "3. Sofia\n" +
                "4. Angelina\n" +
                "5. Alina\n";

        final String firstCall = gameUnderTest.displayHighScores();
        final String secondCall = gameUnderTest.displayHighScores();

        assertEquals(firstExpectedList, firstCall);
        assertEquals(secondExpectedList, secondCall);
    }
}
