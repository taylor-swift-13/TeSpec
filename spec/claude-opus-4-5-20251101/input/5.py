def intersperse_spec_aux(numbers, delimiter):
    if not numbers:
        return []
    res = []
    for x in numbers[:-1]:
        res.append(x)
        res.append(delimiter)
    res.append(numbers[-1])
    return res

def intersperse_spec(numbers, delimiter, result):
    return result == intersperse_spec_aux(numbers, delimiter)
