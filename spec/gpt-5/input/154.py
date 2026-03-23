def substring(s: str, sub: str) -> bool:
    return sub in s

def rotation_of(b: str, rot: str) -> bool:
    if len(b) != len(rot):
        return False
    for i in range(len(b) + 1):
        if rot == b[i:] + b[:i]:
            return True
    return False

def _orig_cycpattern_check_spec(a: str, b: str, output: bool) -> bool:
    expected = False
    if a == b or b == '':
        expected = True
    else:
        for i in range(len(b) + 1):
            rot = b[i:] + b[:i]
            if substring(a, rot):
                expected = True
                break
    return output == expected

def cycpattern_check_spec(a, b, output):
    return bool(_orig_cycpattern_check_spec(a, b, output))
