
def precondition(args):
    if len(args) != 1:
        return False
    s = args[0]
    if not isinstance(s, str):
        return False
    return True

def postcondition(args, output):
    s = args[0]
    if not isinstance(output, list):
        return False
    for word in output:
        if not isinstance(word, str):
            return False
        if len(word) == 0:
            return False
    if s.strip() == "":
        return output == []
    for word in output:
        if word not in s:
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
