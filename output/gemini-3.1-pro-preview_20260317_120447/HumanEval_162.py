
def precondition(input) -> bool:
    return isinstance(input[0], str)

def postcondition(input, output) -> bool:
    if input[0] == "":
        return output is None
    return isinstance(output, str) and len(output) == 32 and all(c in "0123456789abcdefABCDEF" for c in output)

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
