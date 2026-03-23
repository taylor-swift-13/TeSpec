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

def is_nested_spec(string: str, result: bool) -> bool:
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
            
            if valid and depth == 0 and max_depth >= 2:
                has_nested = True
                break
        if has_nested:
            break
            
    return result == has_nested

def _impl(string):
    for i in range(len(string)):
        if string[i] == "]": continue
        cnt, max_nest = 0, 0
        for j in range(i, len(string)):
            if string[j] == "[":
                cnt += 1
            else:
                cnt -= 1
            max_nest = max(max_nest, cnt)
            if cnt == 0:
                if max_nest >= 2:
                    return True
                break
    return False

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(is_nested_spec(*input, output))

def is_nested(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
