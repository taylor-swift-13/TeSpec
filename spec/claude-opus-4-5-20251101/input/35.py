def _orig_max_element_spec(l, output):
    if not l:
        return False
    if output not in l:
        return False
    return all((x <= output for x in l))

def max_element_spec(l, output):
    return bool(_orig_max_element_spec(l, output))
