space_char = ' '

def nospace(s: str) -> bool:
    return ' ' not in s

def join_space(l: list) -> str:
    if not l:
        return ""
    return " ".join(l)

def occ(x: str, l: list) -> int:
    return l.count(x)

# 旧版本把输出写成 list[(token,count)]，和官方 _impl 的 dict 输出不一致。
# def _orig_histogram_spec(test: str, output: list) -> bool:
#     if test == '' and output == []:
#         return True
#     ...

def _orig_histogram_spec(test: str, output) -> bool:
    if test == '' and output == {}:
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
    if not isinstance(output, dict):
        return False
    if any((not isinstance(k, str) or k == '') for k in output):
        return False
    if any((type(n) is not int or n < 0) for n in output.values()):
        return False
    for s, n in output.items():
        if n != m:
            return False
        if occ(s, tokens) != m:
            return False
    for s in set(non_empty_tokens):
        if occ(s, tokens) == m:
            if output.get(s) != m:
                return False
    return True

def histogram_spec(test, output):
    return bool(_orig_histogram_spec(test, output))
