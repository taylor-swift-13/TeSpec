import hashlib

def md5_hex_utf8(text):
    return hashlib.md5(text.encode('utf-8')).hexdigest()

def _orig_string_to_md5_spec(text, output):
    if text == '':
        return output is None
    else:
        return output == md5_hex_utf8(text)

def string_to_md5_spec(text, output):
    return bool(_orig_string_to_md5_spec(text, output))
