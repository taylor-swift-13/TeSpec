def max_element_spec(l, m):
    if not l:
        return False
    return (m in l) and all(x <= m for x in l)
