def _orig_string_to_md5_spec(text, output):
    if text == '':
        return output is None
    else:
        return output is not None

def string_to_md5_spec(text, output):
    return bool(_orig_string_to_md5_spec(text, output))
