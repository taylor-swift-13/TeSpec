
def precondition(args):
    return len(args) == 1 and isinstance(args[0], str)

def postcondition(args, output):
    s = args[0]
    if not isinstance(output, list):
        return False
    if not all(isinstance(item, str) for item in output):
        return False
    
    # The logic involves treating both commas and spaces as delimiters.
    # Replacing commas with spaces and then using split() handles multiple 
    # consecutive delimiters (spaces/commas) correctly.
    expected = s.replace(',', ' ').split()
    return output == expected

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
