def _orig_add_spec(x, y, output):
    return output == x + y

def add_spec(x, y, output):
    return bool(_orig_add_spec(x, y, output))
