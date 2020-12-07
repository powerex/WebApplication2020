package model;

import org.junit.Test;

import static org.junit.Assert.*;

public class UserTest {

    @Test
    public void getId() {
        User user = new User();
        final int expectedId = 3;
        user.setId(expectedId);
        int id = user.getId();
        assertEquals(expectedId, id);
    }

    @Test
    public void getId2() {
        User user = new User();
        final int expectedId = 4;
        user.setId(expectedId);
        int id = user.getId();
        assertEquals(expectedId, id);
    }

    @Test
    public void getPassword() {
    }
}