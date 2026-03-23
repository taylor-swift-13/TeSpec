def _orig_add_elements_spec(arr, k, output):
    k_nat = max(0, int(k))
    first_k = arr[:k_nat]
    filtered = [x for x in first_k if abs(x) < 100]
    return output == sum(filtered)

def add_elements_spec(arr, k, output):
    return bool(_orig_add_elements_spec(arr, k, output))
