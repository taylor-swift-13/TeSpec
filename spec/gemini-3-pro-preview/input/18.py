def _orig_how_many_times_spec(s: str, sub: str, output: int) -> bool:
    count = sum((1 for i in range(len(s)) if s[i:i + len(sub)] == sub))
    return output == count

def how_many_times_spec(string, substring, output):
    return bool(_orig_how_many_times_spec(string, substring, output))
