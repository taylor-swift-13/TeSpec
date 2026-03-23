import hashlib

def md5_hexdigest(text: str) -> str:
    return hashlib.md5(text.encode('latin-1')).hexdigest()

def _orig_string_to_md5_spec(text: str, output) -> bool:
    if text == '':
        return output is None
    else:
        return output == md5_hexdigest(text)

def string_to_md5_spec(text, output):
    return bool(_orig_string_to_md5_spec(text, output))
