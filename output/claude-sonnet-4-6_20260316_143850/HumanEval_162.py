
import hashlib
import re

def precondition(input) -> bool:
    if len(input) != 1:
        return False
    text = input[0]
    if not isinstance(text, str):
        return False
    return True

def postcondition(input, output) -> bool:
    text = input[0]
    if text == "":
        if output is not None:
            return False
    else:
        if not isinstance(output, str):
            return False
        if not re.match(r'^[0-9a-fA-F]{32}$', output):
            return False
        expected = hashlib.md5(text.encode()).hexdigest()
        if output.lower() != expected.lower():
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
