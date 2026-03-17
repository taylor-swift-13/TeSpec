
def precondition(args):
    return isinstance(args[0], str)

def postcondition(args, output):
    text = args[0]
    if text == "":
        return output is None
    if not isinstance(output, str):
        return False
    if len(output) != 32:
        return False
    try:
        int(output, 16)
        return True
    except ValueError:
        return False

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
