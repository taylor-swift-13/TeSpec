def intersperse_spec_aux(numbers, delimiter):
    if not numbers:
        return []
    res = []
    for x in numbers[:-1]:
        res.append(x)
        res.append(delimiter)
    res.append(numbers[-1])
    return res

def _orig_intersperse_spec(numbers, delimiter, output):
    return output == intersperse_spec_aux(numbers, delimiter)

def intersperse_spec(numbers, delimeter, output):
    return bool(_orig_intersperse_spec(numbers, delimeter, output))
