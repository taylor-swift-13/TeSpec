def substring(s: str, start: int, len_: int) -> str:
    return s[start:start + len_]

def prefix(s: str, len_: int) -> str:
    return substring(s, 0, len_)

def all_prefixes_helper(s: str, n: int) -> list:
    res = []
    for i in range(1, n + 1):
        res.append(prefix(s, i))
    return res

def all_prefixes_spec(s: str, result: list) -> bool:
    length = len(s)
    
    if result != all_prefixes_helper(s, length):
        return False
        
    if len(result) != length:
        return False
        
    for i in range(length):
        val = result[i] if i < len(result) else ""
        if val != prefix(s, i + 1):
            return False
            
    return True
