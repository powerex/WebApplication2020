package logic;

import org.junit.Test;

import static org.junit.Assert.*;

public class HashCheckerTest {

    @Test
    public void isSame() {
        assertTrue(HashChecker.isSame("Hello", "8b1a9953c4611296a827abf8c47804d7".toUpperCase()));
        assertFalse(HashChecker.isSame("Hello", "8b1a9953c4611296a827abf8c47804d8".toUpperCase()));
    }
}