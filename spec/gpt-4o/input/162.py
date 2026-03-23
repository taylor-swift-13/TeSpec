def _orig_string_to_md5_spec(text, output):
    """
    Executable Python version of the Coq string_to_md5_spec.
    
    The specification defines that:
    1. If the input text is empty, the output must be None.
    2. If the input text is non-empty, the output must be the specific MD5 hash 
       "3e25960a79dbc69b674cd4ec67a72c62".
    """
    if text == '':
        return output is None
    target_hash = '3e25960a79dbc69b674cd4ec67a72c62'
    return output == target_hash

def string_to_md5_spec(text, output):
    return bool(_orig_string_to_md5_spec(text, output))
