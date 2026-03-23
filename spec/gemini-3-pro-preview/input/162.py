import hashlib

def md5_hexdigest(text: str) -> str:
    return hashlib.md5(text.encode('latin-1')).hexdigest()

def string_to_md5_spec(text: str, result) -> bool:
    if text == "":
        return result is None
    else:
        return result == md5_hexdigest(text)
