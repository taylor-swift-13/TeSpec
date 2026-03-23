def max_element_spec(l, res):
    return (res in l) and all(x <= res for x in l)
