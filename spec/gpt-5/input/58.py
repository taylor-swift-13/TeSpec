def common_spec(l1, l2, out):
    if len(out) != len(set(out)):
        return False
    if out != sorted(out):
        return False
    if set(out) != set(l1).intersection(set(l2)):
        return False
    return True
