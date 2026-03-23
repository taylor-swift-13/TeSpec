def string_to_list(s: str) -> list:
    return list(s)

LBracket = '['

RBracket = ']'

def balanced_depth(s: list, d: int) -> bool:
    if not isinstance(s, list):
        return False
    depth = 0
    max_depth = 0
    for char in s:
        if char == LBracket:
            depth += 1
            if depth > max_depth:
                max_depth = depth
        elif char == RBracket:
            depth -= 1
            if depth < 0:
                return False
        else:
            return False
    return depth == 0 and max_depth == d

def is_substring(sub: list, s: list) -> bool:
    n = len(s)
    m = len(sub)
    if m == 0:
        return True
    for i in range(n - m + 1):
        if s[i:i+m] == sub:
            return True
    return False

def _orig_is_nested_spec(string: str, output: bool) -> bool:
    chars = string_to_list(string)
    n = len(chars)
    has_nested = False
    for i in range(n):
        for j in range(i, n + 1):
            sub = chars[i:j]
            depth = 0
            max_depth = 0
            valid = True
            for char in sub:
                if char == LBracket:
                    depth += 1
                    if depth > max_depth:
                        max_depth = depth
                elif char == RBracket:
                    depth -= 1
                    if depth < 0:
                        valid = False
                        break
                else:
                    valid = False
                    break
            if valid and depth == 0 and (max_depth >= 2):
                has_nested = True
                break
        if has_nested:
            break
    return output == has_nested

def is_nested_spec(string, output):
    return bool(_orig_is_nested_spec(string, output))
