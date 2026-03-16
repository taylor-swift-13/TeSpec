
import re

def precondition(input):
    try:
        if not isinstance(input, tuple):
            return False
        if len(input) != 1:
            return False
        s = input[0]
        return isinstance(s, str)
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not precondition(input):
            return False
        s = input[0]
        if not isinstance(output, (list, tuple)):
            return False
        # each element must be a non-empty string
        for item in output:
            if not isinstance(item, str):
                return False
            if item == "":
                return False
        # expected tokens: split on commas or any whitespace, ignore empty tokens
        expected = [tok for tok in re.split(r'[,\s]+', s) if tok != ""]
        return list(output) == expected
    except Exception:
        return False

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
