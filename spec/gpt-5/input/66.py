def digitSum_fun(s: str) -> int:
    total = 0
    for ch in s:
        code = ord(ch)
        if 65 <= code <= 90:
            total += code
    return total

def digitSum_spec(s: str, sum: int) -> bool:
    return sum == digitSum_fun(s)
