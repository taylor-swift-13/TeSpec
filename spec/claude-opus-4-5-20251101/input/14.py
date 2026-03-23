def substring(s: str, start: int, len_: int) -> str:
    return s[start:start + len_]

def prefix(s: str, len_: int) -> str:
    return substring(s, 0, len_)

def all_prefixes_helper(s: str, n: int) -> list:
    res = []
    for i in range(1, n + 1):
        res.append(prefix(s, i))
    return res

def _orig_all_prefixes_spec(s: str, output: list) -> bool:
    length = len(s)
    if output != all_prefixes_helper(s, length):
        return False
    if len(output) != length:
        return False
    for i in range(length):
        val = output[i] if i < len(output) else ''
        if val != prefix(s, i + 1):
            return False
    return True

def all_prefixes_spec(string, output):
    return bool(_orig_all_prefixes_spec(string, output))
