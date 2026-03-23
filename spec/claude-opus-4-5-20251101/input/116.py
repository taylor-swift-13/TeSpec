def count_ones_pos(p: int) -> int:
    return bin(p).count('1')

def count_ones(z: int) -> int:
    return bin(abs(z)).count('1')

def cmp(x: int, y: int) -> str:
    x1 = count_ones(x)
    y1 = count_ones(y)
    if x1 < y1:
        return "Lt"
    elif x1 > y1:
        return "Gt"
    else:
        if x < y:
            return "Lt"
        elif x > y:
            return "Gt"
        else:
            return "Eq"

def le_by_cmp(x: int, y: int) -> bool:
    res = cmp(x, y)
    return res == "Lt" or res == "Eq"

def lt_by_cmp(x: int, y: int) -> bool:
    return cmp(x, y) == "Lt"

def sort_array_spec(arr: list, result: list) -> bool:
    if sorted(arr) != sorted(result):
        return False
    for i in range(len(result)):
        for j in range(i + 1, len(result)):
            if not le_by_cmp(result[i], result[j]):
                return False
    return True
