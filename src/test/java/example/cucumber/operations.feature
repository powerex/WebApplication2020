Feature: A simple math BDD test

  Scenario Outline: Two numbers can be added
    Given the numbers <a> and <b>
    When the numbers are added together
    Then the result is <result>
    When the numbers are subtracts
    Then the sub is <sub>

    Examples:
      |  a|  b|result|  sub|
      |  1| 10|    11|   -9|
      |  0|  0|     0|    0|
      | 10| -5|     5|   15|
      | -1|  1|     0|   -2|