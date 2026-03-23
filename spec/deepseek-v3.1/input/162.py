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
