import hashlib

def string_to_md5(text: str):
    if text == "":
        return None
    return hashlib.md5(text.encode('utf-8')).hexdigest()

def string_to_md5_spec(text: str, result) -> bool:
    if text == "":
        return result is None
    else:
        return result is not None and isinstance(result, str)

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
