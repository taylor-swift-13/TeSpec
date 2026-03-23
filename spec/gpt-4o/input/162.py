def string_to_md5_spec(text, result):
    """
    Executable Python version of the Coq string_to_md5_spec.
    
    The specification defines that:
    1. If the input text is empty, the result must be None.
    2. If the input text is non-empty, the result must be the specific MD5 hash 
       "3e25960a79dbc69b674cd4ec67a72c62".
    """
    # (text = "" /\ result = None)
    if text == "":
        return result is None
    
    # (text <> "" /\ exists hash : string, result = Some hash /\ hash = "3e25960a79dbc69b674cd4ec67a72c62")
    # In Python, result = Some hash is represented by result being the string itself.
    # The existence of such a hash is satisfied if result matches the target string.
    target_hash = "3e25960a79dbc69b674cd4ec67a72c62"
    return result == target_hash
