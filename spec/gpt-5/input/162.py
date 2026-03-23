import hashlib

def md5_hex_utf8(text):
    return hashlib.md5(text.encode('utf-8')).hexdigest()

def string_to_md5_spec(text, res):
    if text == "":
        return res is None
    else:
        return res == md5_hex_utf8(text)
