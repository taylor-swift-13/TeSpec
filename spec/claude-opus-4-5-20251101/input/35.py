def max_element_spec(l, result):
    if not l:
        return False
    if result not in l:
        return False
    return all(x <= result for x in l)
