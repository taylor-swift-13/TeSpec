
def precondition(input):
    text = input[0]
    return isinstance(text, str)

def postcondition(input, output):
    text = input[0]
    if text == "":
        return output is None
    return isinstance(output, str) and len(output) == 32

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
