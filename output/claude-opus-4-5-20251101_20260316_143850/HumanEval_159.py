
def precondition(input):
    if len(input) != 3:
        return False
    number, need, remaining = input
    # Check all are integers
    if not isinstance(number, int) or isinstance(number, bool):
        return False
    if not isinstance(need, int) or isinstance(need, bool):
        return False
    if not isinstance(remaining, int) or isinstance(remaining, bool):
        return False
    # Check constraints
    if not (0 <= number <= 1000):
        return False
    if not (0 <= need <= 1000):
        return False
    if not (0 <= remaining <= 1000):
        return False
    return True


def postcondition(input, output):
    if not precondition(input):
        return False
    number, need, remaining = input
    # Output should be a list of two integers
    if not isinstance(output, list):
        return False
    if len(output) != 2:
        return False
    total_eaten, carrots_left = output
    if not isinstance(total_eaten, int) or isinstance(total_eaten, bool):
        return False
    if not isinstance(carrots_left, int) or isinstance(carrots_left, bool):
        return False
    # Calculate expected values
    actually_eaten = min(need, remaining)
    expected_total = number + actually_eaten
    expected_left = remaining - actually_eaten
    # Verify output matches expected
    if total_eaten != expected_total:
        return False
    if carrots_left != expected_left:
        return False
    # Additional sanity checks
    if total_eaten < number:
        return False
    if carrots_left < 0:
        return False
    if carrots_left > remaining:
        return False
    return True

def _impl(number, need, remaining):
    """You're a hungry rabbit, and you already have eaten a certain number of carrots,
    but now you need to eat more carrots to complete the day's meals.
    you should return an array of [ total number of eaten carrots after your meals,
                                    the number of carrots left after your meals ]
    if there are not enough remaining carrots, you will eat all remaining carrots, but will still be hungry.

    Example:
    * eat(5, 6, 10) -> [11, 4]
    * eat(4, 8, 9) -> [12, 1]
    * eat(1, 10, 10) -> [11, 0]
    * eat(2, 11, 5) -> [7, 0]

    Variables:
    @number : integer
        the number of carrots that you have eaten.
    @need : integer
        the number of carrots that you need to eat.
    @remaining : integer
        the number of remaining carrots thet exist in stock

    Constrain:
    * 0 <= number <= 1000
    * 0 <= need <= 1000
    * 0 <= remaining <= 1000

    Have fun :)"""
    if need <= remaining:
        return [number + need, remaining - need]
    else:
        return [number + remaining, 0]

def eat(number, need, remaining):
    _input = (number, need, remaining)
    assert precondition(_input)
    _output = _impl(number, need, remaining)
    assert postcondition(_input, _output)
    return _output
