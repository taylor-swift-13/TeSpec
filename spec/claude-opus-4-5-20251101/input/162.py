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
