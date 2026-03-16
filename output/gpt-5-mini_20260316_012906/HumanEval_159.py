
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 3:
        return False
    number, need, remaining = input
    for v in (number, need, remaining):
        if type(v) is not int:
            return False
        if v < 0 or v > 1000:
            return False
    return True

def postcondition(input, output):
    # If precondition doesn't hold, don't enforce postcondition here.
    if not precondition(input):
        return True
    number, need, remaining = input
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != 2:
        return False
    out_total, out_remaining = output
    if type(out_total) is not int or type(out_remaining) is not int:
        return False
    eaten_now = need if remaining >= need else remaining
    expected_total = number + eaten_now
    expected_remaining = remaining - eaten_now
    return out_total == expected_total and out_remaining == expected_remaining

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
