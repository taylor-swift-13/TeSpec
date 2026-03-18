
def precondition(input):
    # input is a tuple of positional arguments in order
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    # Accept any string, including empty
    return True

def postcondition(input, output):
    # Validate input shape
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False

    # If text is empty, output must be None
    if text == "":
        return output is None

    # For non-empty text, output must be the md5 hexdigest of text
    try:
        import hashlib
        expected = hashlib.md5(text.encode('utf-8')).hexdigest()
    except Exception:
        return False

    if not isinstance(output, str):
        return False
    return output == expected

def _impl(text):
    """
    Given a string 'text', return its md5 hash equivalent string.
    If 'text' is an empty string, return None.
    """
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
