
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 3:
        return False
    number, need, remaining = input
    def is_int(x):
        return isinstance(x, int) and not isinstance(x, bool)
    if not (is_int(number) and is_int(need) and is_int(remaining)):
        return False
    if not (0 <= number <= 1000):
        return False
    if not (0 <= need <= 1000):
        return False
    if not (0 <= remaining <= 1000):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    number, need, remaining = input
    if not (isinstance(output, (list, tuple)) and len(output) == 2):
        return False
    tot, left = output[0], output[1]
    if not (isinstance(tot, int) and not isinstance(tot, bool)):
        return False
    if not (isinstance(left, int) and not isinstance(left, bool)):
        return False
    eaten = need if need <= remaining else remaining
    expected_tot = number + eaten
    expected_left = remaining - eaten
    if tot != expected_tot:
        return False
    if left != expected_left:
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
