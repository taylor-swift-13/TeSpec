def is_space_bool(c):
    return c == ' '

def insert_char(c, s):
    for i, h in enumerate(s):
        if ord(c) <= ord(h):
            return s[:i] + c + s[i:]
    return s + c

def sort_chars(s):
    return "".join(sorted(s))

def anti_shuffle_aux(s, acc):
    result = []
    current_acc = acc
    for c in s:
        if is_space_bool(c):
            result.append(sort_chars(current_acc))
            result.append(c)
            current_acc = ""
        else:
            current_acc = c + current_acc
    result.append(sort_chars(current_acc))
    return "".join(result)

def anti_shuffle_impl(s):
    return anti_shuffle_aux(s, "")

def _orig_problem_86_pre(s):
    return True

def _orig_problem_86_spec(s, s_out):
    return s_out == anti_shuffle_impl(s)

def problem_86_pre(s):
    return bool(_orig_problem_86_pre(s))

def problem_86_spec(s, output):
    return bool(_orig_problem_86_spec(s, output))
