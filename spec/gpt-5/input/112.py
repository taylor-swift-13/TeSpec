def rev_string_acc(s: str, acc: str) -> str:
    return s[::-1] + acc

def rev_string(s: str) -> str:
    return s[::-1]

def CharIn(ch: str, s: str) -> bool:
    return ch in s

def Filtered(s: str, c: str, ss: str) -> bool:
    expected_ss = "".join([ch for ch in s if ch not in c])
    return expected_ss == ss

def _orig_reverse_delete_spec(s: str, c: str, out: tuple) -> bool:
    if not isinstance(out, tuple) or len(out) != 2:
        return False
    (ss, b) = out
    expected_ss = ''.join([ch for ch in s if ch not in c])
    expected_b = expected_ss == expected_ss[::-1]
    return ss == expected_ss and b == expected_b

def reverse_delete_spec(s, c, output):
    return bool(_orig_reverse_delete_spec(s, c, output))
