def _orig_max_element_spec(l, output):
    return output in l and all((x <= output for x in l))

def max_element_spec(l, output):
    return bool(_orig_max_element_spec(l, output))
