
import hashlib

def precondition(input):
    # Check that input is a tuple with exactly one element
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    
    text = input[0]
    
    # Check that text is a string
    if not isinstance(text, str):
        return False
    
    return True

def postcondition(input, output):
    text = input[0]
    
    # If text is empty, output should be None
    if text == "":
        return output is None
    
    # If text is non-empty, output should be the md5 hash string
    if output is None:
        return False
    
    # Check that output is a string
    if not isinstance(output, str):
        return False
    
    # Check that output is a valid md5 hash (32 hexadecimal characters)
    if len(output) != 32:
        return False
    
    # Check that all characters are valid hexadecimal
    try:
        int(output, 16)
    except ValueError:
        return False
    
    # Verify the hash is correct
    expected_hash = hashlib.md5(text.encode()).hexdigest()
    if output != expected_hash:
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
