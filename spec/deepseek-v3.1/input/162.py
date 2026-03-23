import hashlib

def string_to_md5(text: str):
    if text == "":
        return None
    return hashlib.md5(text.encode('utf-8')).hexdigest()

def _orig_string_to_md5_spec(text: str, output) -> bool:
    if text == '':
        return output is None
    else:
        return output is not None and isinstance(output, str)

def string_to_md5_spec(text, output):
    return bool(_orig_string_to_md5_spec(text, output))
