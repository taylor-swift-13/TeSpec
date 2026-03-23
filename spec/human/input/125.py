def contains(l, c):
    return c in l

def split(sep, s):
    return [w for w in s.split(sep) if w]

def count_odd_lowercase(l):
    count = 0
    for c in l:
        if 'a' <= c <= 'z':
            if (ord(c) - ord('a')) % 2 != 0:
                count += 1
    return count

def _orig_problem_125_pre(input):
    return True

# 旧版本要求输出带 inl/inr 标签，和官方 _impl 的返回类型不一致。
# def _orig_problem_125_spec(input, output):
#     if contains(input, ' '):
#         res = split(' ', input)
#         is_inl = True
#     elif contains(input, ','):
#         res = split(',', input)
#         is_inl = True
#     else:
#         res = count_odd_lowercase(input)
#         is_inl = False
#     if is_inl:
#         return output == ('inl', res) or output == ['inl', res] or output == {'inl': res}
#     else:
#         return output == ('inr', res) or output == ['inr', res] or output == {'inr': res}

def _orig_problem_125_spec(input, output):
    if contains(input, ' '):
        return isinstance(output, list) and all((isinstance(w, str) for w in output)) and output == split(' ', input)
    if contains(input, ','):
        return isinstance(output, list) and all((isinstance(w, str) for w in output)) and output == split(',', input)
    return type(output) is int and output >= 0 and output == count_odd_lowercase(input)

def problem_125_pre(txt):
    return bool(_orig_problem_125_pre(txt))

def problem_125_spec(txt, output):
    return bool(_orig_problem_125_spec(txt, output))
