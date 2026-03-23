def common_spec(l1, l2, res):
    if res != sorted(res):
        return False
    if len(res) != len(set(res)):
        return False
    if set(res) != set(l1).intersection(set(l2)):
        return False
    return True
