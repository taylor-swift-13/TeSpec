
import hashlib

def precondition(args):
    text = args[0]
    return isinstance(text, str)

def postcondition(args, result):
    text = args[0]
    if text == "":
        return result is None
    else:
        return isinstance(result, str) and len(result) == 32 and all(c in "0123456789abcdef" for c in result)

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
