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

def problem_125_pre(input):
    return True

def problem_125_spec(input, output):
    if contains(input, " "):
        res = split(" ", input)
        is_inl = True
    elif contains(input, ","):
        res = split(",", input)
        is_inl = True
    else:
        res = count_odd_lowercase(input)
        is_inl = False

    if is_inl:
        return output == ('inl', res) or output == ['inl', res] or output == {'inl': res}
    else:
        return output == ('inr', res) or output == ['inr', res] or output == {'inr': res}
