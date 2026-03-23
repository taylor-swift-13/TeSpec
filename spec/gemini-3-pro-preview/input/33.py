def extract_thirds(l, i):
    output = []
    for j, x in enumerate(l):
        if (i + j) % 3 == 0:
            output.append(x)
    return output

def _orig_sort_third_spec(l, output):
    if len(output) != len(l):
        return False
    for i in range(len(l)):
        if i % 3 != 0:
            if output[i] != l[i]:
                return False
    ext_res = extract_thirds(output, 0)
    ext_l = extract_thirds(l, 0)
    if sorted(ext_res) != sorted(ext_l):
        return False
    if ext_res != sorted(ext_res):
        return False
    return True

def sort_third_spec(l, output):
    return bool(_orig_sort_third_spec(l, output))
