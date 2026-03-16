
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s, n = input
    if not isinstance(s, str):
        return False
    if not isinstance(n, int):
        return False
    # Find at least two non-negative integer tokens in the string
    try:
        import re
        nums = re.findall(r'\d+', s)
        return len(nums) >= 2
    except Exception:
        return False

def postcondition(input, output):
    # Postcondition applies only when precondition holds
    if not precondition(input):
        return True
    s, n = input
    import re
    nums = re.findall(r'\d+', s)
    a = int(nums[0])
    b = int(nums[1])
    expected = n - a - b
    return isinstance(output, int) and output == expected

def _impl(s,n):
    """In this task, you will be given a string that represents a number of apples and oranges 
    that are distributed in a basket of fruit this basket contains 
    apples, oranges, and mango fruits. Given the string that represents the total number of 
    the oranges and apples and an integer that represent the total number of the fruits 
    in the basket return the number of the mango fruits in the basket.
    for examble:
    fruit_distribution("5 apples and 6 oranges", 19) ->19 - 5 - 6 = 8
    fruit_distribution("0 apples and 1 oranges",3) -> 3 - 0 - 1 = 2
    fruit_distribution("2 apples and 3 oranges", 100) -> 100 - 2 - 3 = 95
    fruit_distribution("100 apples and 1 oranges",120) -> 120 - 100 - 1 = 19"""
    words = s.split(" ")
    c1, c2 = int(words[0]), int(words[3])
    assert n - c1 - c2 >= 0, "invalid inputs" # $_CONTRACT_$

    return n - c1 - c2

def fruit_distribution(s,n):
    _input = (s, n)
    assert precondition(_input)
    _output = _impl(s, n)
    assert postcondition(_input, _output)
    return _output
