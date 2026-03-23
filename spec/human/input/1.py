lparen = "("
rparen = ")"
space = " "

def IsBalanced_aux(s, count):
    if not s:
        return count == 0
    h = s[0]
    t = s[1:]
    if h == lparen:
        return IsBalanced_aux(t, count + 1)
    elif h == rparen:
        if count == 0:
            return False
        return IsBalanced_aux(t, count - 1)
    else:
        return IsBalanced_aux(t, count)

def IsBalanced(s):
    return IsBalanced_aux(s, 0)

def remove_spaces(s):
    if not s:
        return ""
    h = s[0]
    t = s[1:]
    if h == space:
        return remove_spaces(t)
    else:
        return h + remove_spaces(t)

def is_paren_or_space(c):
    return c == lparen or c == rparen or c == space

def ForallChars(P, s):
    if not s:
        return True
    h = s[0]
    t = s[1:]
    return P(h) and ForallChars(P, t)

def separate_paren_groups_aux(s, count, current, acc):
    if not s:
        if not current:
            return acc
        else:
            return acc + ["".join(reversed(current))]

    h = s[0]
    t = s[1:]

    if h == lparen:
        return separate_paren_groups_aux(t, count + 1, [h] + current, acc)
    elif h == rparen:
        if count == 0:
            return acc
        else:
            n_prime = count - 1
            new_current = [h] + current
            if n_prime == 0:
                return separate_paren_groups_aux(t, n_prime, [], acc + ["".join(reversed(new_current))])
            else:
                return separate_paren_groups_aux(t, n_prime, new_current, acc)
    elif h == space:
        return separate_paren_groups_aux(t, count, current, acc)
    else:
        return separate_paren_groups_aux(t, count, [h] + current, acc)

def separate_paren_groups_impl(input_str):
    return separate_paren_groups_aux(remove_spaces(input_str), 0, [], [])

def problem_1_pre(input_str):
    return ForallChars(is_paren_or_space, input_str) and IsBalanced(remove_spaces(input_str))

def problem_1_spec(input_str, output):
    return output == separate_paren_groups_impl(input_str)
