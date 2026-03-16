
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 3:
        return False
    number, need, remaining = input
    if not isinstance(number, int) or not isinstance(need, int) or not isinstance(remaining, int):
        return False
    if not (0 <= number <= 1000 and 0 <= need <= 1000 and 0 <= remaining <= 1000):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    try:
        number, need, remaining = input
        expected_total = number + min(need, remaining)
        expected_remaining = remaining - min(need, remaining)
        if not isinstance(output, (list, tuple)) or len(output) != 2:
            return False
        total, rem_after = output
        if not isinstance(total, int) or not isinstance(rem_after, int):
            return False
        if total != expected_total or rem_after != expected_remaining:
            return False
        return True
    except Exception:
        return False

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
