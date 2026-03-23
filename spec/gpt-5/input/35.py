def _orig_max_element_spec(l, m):
    if not l:
        return False
    return m in l and all((x <= m for x in l))

def max_element_spec(l, output):
    return bool(_orig_max_element_spec(l, output))
