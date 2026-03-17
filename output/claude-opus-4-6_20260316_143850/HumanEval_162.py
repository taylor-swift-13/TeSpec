
def precondition(input):
    args = input
    if len(args) != 1:
        return False
    text = args[0]
    if not isinstance(text, str):
        return False
    return True


def postcondition(input, output):
    args = input
    text = args[0]
    
    if text == "":
        return output is None
    
    # Output should be a string
    if not isinstance(output, str):
        return False
    
    # MD5 hex digest is always 32 hex characters
    if len(output) != 32:
        return False
    
    # Should only contain hex characters
    try:
        int(output, 16)
    except ValueError:
        return False
    
    # Verify it matches the actual md5 hash
    import hashlib
    expected = hashlib.md5(text.encode('utf-8')).hexdigest()
    if output != expected:
        return False
    
    return True

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
