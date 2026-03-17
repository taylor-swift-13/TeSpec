
def precondition(args):
    if len(args) != 1:
        return False
    s = args[0]
    if not isinstance(s, str):
        return False
    return True


def postcondition(args, output):
    if not precondition(args):
        return False
    s = args[0]
    if not isinstance(output, list):
        return False
    if not all(isinstance(word, str) for word in output):
        return False
    # All output words should be non-empty and contain no commas or spaces
    for word in output:
        if len(word) == 0:
            return False
        if ',' in word or ' ' in word:
            return False
    # All output words should appear in the original string
    for word in output:
        if word not in s:
            return False
    # If input is empty or contains only separators, output should be empty
    normalized = s.replace(',', ' ')
    expected_words = normalized.split()
    if len(expected_words) == 0:
        return len(output) == 0
    # The number of words should match
    if len(output) != len(expected_words):
        return False
    return True

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
