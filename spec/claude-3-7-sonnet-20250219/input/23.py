def _orig_strlen_spec(string, length):
    return length == len(string)

def strlen_spec(string, output):
    return bool(_orig_strlen_spec(string, output))
