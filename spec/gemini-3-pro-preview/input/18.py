def how_many_times_spec(s: str, sub: str, res: int) -> bool:
    count = sum(1 for i in range(len(s)) if s[i:i+len(sub)] == sub)
    return res == count
