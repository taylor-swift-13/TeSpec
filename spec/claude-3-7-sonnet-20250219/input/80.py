def happy(s: str) -> bool:
    if len(s) < 3:
        return False
    for i in range(len(s) - 2):
        a = s[i]
        b = s[i + 1]
        c = s[i + 2]
        if a == b or a == c or b == c:
            return False
    return True

def is_happy_spec(s: str, res: bool) -> bool:
    return res == happy(s)
