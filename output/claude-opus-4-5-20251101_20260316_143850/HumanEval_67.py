
def precondition(input):
    if len(input) != 2:
        return False
    s, n = input
    if not isinstance(s, str):
        return False
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    # Check that string contains the expected format with two numbers
    import re
    pattern = r'(\d+)\s+apples\s+and\s+(\d+)\s+oranges'
    match = re.search(pattern, s)
    if not match:
        return False
    apples = int(match.group(1))
    oranges = int(match.group(2))
    # Total fruits must be at least apples + oranges (mangos >= 0)
    if n < apples + oranges:
        return False
    return True


def postcondition(input, output):
    if len(input) != 2:
        return False
    s, n = input
    if not isinstance(output, int):
        return False
    # Extract apples and oranges from string
    import re
    pattern = r'(\d+)\s+apples\s+and\s+(\d+)\s+oranges'
    match = re.search(pattern, s)
    if not match:
        return False
    apples = int(match.group(1))
    oranges = int(match.group(2))
    # Output should be total minus apples minus oranges
    expected_mangos = n - apples - oranges
    if output != expected_mangos:
        return False
    # Mangos should be non-negative
    if output < 0:
        return False
    return True

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
