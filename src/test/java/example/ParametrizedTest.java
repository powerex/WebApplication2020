package example;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.Parameterized;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertEquals;

@RunWith(Parameterized.class)
public class ParametrizedTest {

    private final int a;
    private final int b;
    private final int expectedAddiction;
    private final int expectedSubtraction;
    private final int expectedMultiplication;
    private final int expectedDivision;


    public ParametrizedTest(int a, int b, int expectedAddiction, int expectedSubctruction, int expectedMultiplication, int expectedDivision) {
        this.a = a;
        this.b = b;
        this.expectedAddiction = expectedAddiction;
        this.expectedSubtraction = expectedSubctruction;
        this.expectedMultiplication = expectedMultiplication;
        this.expectedDivision = expectedDivision;
    }

    @Parameterized.Parameters
    public static List<Integer[]> parameters() {
        return new ArrayList<>() {{
            add(new Integer[]{1, 2, 3, -1, 2, 0});
            add(new Integer[]{0, 1, 1, -1, 0, 0});
            add(new Integer[]{-11, 2, -9, -13, -22, -5});
        }};
    }

    @Test
    public void addNumbers() {
        assertEquals(expectedAddiction, a+b);
    }

    @Test
    public void subtractNumbers() {
        assertEquals(expectedSubtraction, a-b);
    }

    @Test
    public void multiplyNumbers() {
        assertEquals(expectedMultiplication, a*b);
    }

    @Test
    public void divideNumbers() {
        assertEquals(expectedDivision, a/b);
    }
}
