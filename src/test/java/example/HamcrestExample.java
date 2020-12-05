package example;

import org.junit.Test;

import static org.hamcrest.CoreMatchers.*;
import static org.hamcrest.MatcherAssert.*;

public class HamcrestExample {

    @Test
    public void useHamcrest() {
        final Integer a = 400;

        assertThat(a, is(notNullValue()));
        assertThat(a, is(equalTo(400)));
    }

}
