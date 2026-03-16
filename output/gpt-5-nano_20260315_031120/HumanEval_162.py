
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) < 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    if text == '':
        return output is None
    import hashlib
    expected = hashlib.md5(text.encode('utf-8')).hexdigest()
    return isinstance(output, str) and output == expected

def _impl(text):
    """Given a string 'text', return its md5 hash equivalent string.
    If 'text' is an empty string, return None."""
    if text == "": return None
    import hashlib
    m = hashlib.md5()
    m.update(text.encode("utf-8"))
    return m.hexdigest()

def string_to_md5(text):
    _input = (text,)
    assert precondition(_input)
    _output = _impl(text)
    assert postcondition(_input, _output)
    return _output
