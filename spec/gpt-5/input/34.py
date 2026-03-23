def _orig_unique_spec(l, output):
    if output != sorted(output):
        return False
    if len(output) != len(set(output)):
        return False
    if set(output) != set(l):
        return False
    return True

def unique_spec(l, output):
    return bool(_orig_unique_spec(l, output))
