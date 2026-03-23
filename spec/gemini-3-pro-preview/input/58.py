def _orig_common_spec(l1, l2, output):
    if output != sorted(output):
        return False
    if len(output) != len(set(output)):
        return False
    if set(output) != set(l1).intersection(set(l2)):
        return False
    return True

def common_spec(l1, l2, output):
    return bool(_orig_common_spec(l1, l2, output))
