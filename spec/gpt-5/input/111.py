space_char = ' '

def nospace(s: str) -> bool:
    return ' ' not in s

def join_space(l: list) -> str:
    if not l:
        return ""
    return " ".join(l)

def occ(x: str, l: list) -> int:
    return l.count(x)

def _orig_histogram_spec(test: str, output: list) -> bool:
    if test == '' and output == []:
        return True
    if test == '':
        return False
    tokens = test.split(' ')
    if any((not nospace(t) for t in tokens)):
        return False
    if join_space(tokens) != test:
        return False
    non_empty_tokens = [t for t in tokens if t != '']
    if not non_empty_tokens:
        return False
    m = max((occ(t, tokens) for t in non_empty_tokens))
    ans_keys = [k for (k, v) in output]
    if len(ans_keys) != len(set(ans_keys)):
        return False
    for (s, n) in output:
        if n != m:
            return False
        if s == '':
            return False
        if occ(s, tokens) != m:
            return False
    for s in set(non_empty_tokens):
        if occ(s, tokens) == m:
            if not any((k == s and v == m for (k, v) in output)):
                return False
    return True

def histogram_spec(test, output):
    return bool(_orig_histogram_spec(test, output))
