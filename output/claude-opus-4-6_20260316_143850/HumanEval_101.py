
def precondition(input):
    (s,) = input
    if not isinstance(s, str):
        return False
    return True


def postcondition(input, output):
    (s,) = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(w, str) for w in output):
        return False
    # Each word in the output should be non-empty and contain no commas or spaces
    for w in output:
        if len(w) == 0:
            return False
        if ',' in w or ' ' in w:
            return False
    # Reconstructing: joining output words should match the non-separator content of s
    # All characters in s that are not commas or spaces should appear in order in the output
    extracted = ''.join(output)
    original_chars = s.replace(',', '').replace(' ', '')
    if extracted != original_chars:
        return False
    # If the string has no non-separator content, output should be empty
    if original_chars == '' and output != []:
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
