
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    # Compute expected tokens: split on commas or spaces, ignore empty tokens
    tokens = []
    current = []
    for ch in s:
        if ch == ',' or ch == ' ':
            if current:
                tokens.append(''.join(current))
                current = []
        else:
            current.append(ch)
    if current:
        tokens.append(''.join(current))
    if not isinstance(output, (list, tuple)):
        return False
    if not all(isinstance(x, str) for x in output):
        return False
    return list(output) == tokens

def _impl(s):
    """You will be given a string of words separated by commas or spaces. Your task is
    to split the string into words and return an array of the words.

    For example:
    words_string("Hi, my name is John") == ["Hi", "my", "name", "is", "John"]
    words_string("One, two, three, four, five, six") == ["One", "two", "three", "four", "five", "six"]"""
    words = (s.replace(",", " ")).split()
    return [word for word in words if word != ""]

def words_string(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
