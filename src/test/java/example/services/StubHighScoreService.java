package example.services;

import java.util.List;

public class StubHighScoreService implements HighScoreService {
    @Override
    public List<String> getTopFivePlayers() {
        return null;
    }

    @Override
    public boolean saveHighScore(int score, String playerName) {
        return false;
    }
}
