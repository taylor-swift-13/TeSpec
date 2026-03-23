def split(s: str, sep: str) -> list:
    return s.split(sep)

def to_int(s: str) -> int:
    try:
        return int(s)
    except ValueError:
        return 0

def fruit_distribution_spec(s: str, n: int, res: int) -> bool:
    words = split(s, " ")
    c1_str = words[0] if len(words) > 0 else ""
    c2_str = words[3] if len(words) > 3 else ""
    
    c1 = to_int(c1_str)
    c2 = to_int(c2_str)
    
    return (n - c1 - c2 >= 0) and (res == n - c1 - c2)
