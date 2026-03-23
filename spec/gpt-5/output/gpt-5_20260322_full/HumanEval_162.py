import hashlib

def md5_hex_utf8(text):
    return hashlib.md5(text.encode('utf-8')).hexdigest()

def string_to_md5_spec(text, res):
    if text == "":
        return res is None
    else:
        return res == md5_hex_utf8(text)

def _impl(text):
    if text == "": return None
    import hashlib
    m = hashlib.md5()
    m.update(text.encode("utf-8"))
    return m.hexdigest()

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(string_to_md5_spec(*input, output))

def string_to_md5(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
