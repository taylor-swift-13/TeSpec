def string_to_md5_spec(text, result):
    if text == "":
        # (text = EmptyString -> result = None)
        # If text is empty, result must be None.
        # The second part of the conjunction (text <> EmptyString -> ...) 
        # is vacuously true in this case.
        return result is None
    else:
        # (text <> EmptyString -> exists hash : string, result = Some hash)
        # If text is not empty, result must be Some hash (i.e., not None).
        # The first part of the conjunction (text = EmptyString -> ...) 
        # is vacuously true in this case.
        return result is not None

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
