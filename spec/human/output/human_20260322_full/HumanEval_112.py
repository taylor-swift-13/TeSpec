def list_eqb(eq, l1, l2):
    """
    Compares two lists for equality using a provided equality function.
    Equivalent to Coq's list_eqb.
    """
    if len(l1) != len(l2):
        return False
    for x1, x2 in zip(l1, l2):
        if not eq(x1, x2):
            return False
    return True

def existsb(f, l):
    """
    Checks if any element in a list satisfies a predicate.
    Equivalent to Coq's existsb.
    """
    for h in l:
        if f(h):
            return True
    return False

def delete_chars_impl(s, c):
    """
    Filters out characters from list s that exist in list c.
    Equivalent to Coq's delete_chars_impl.
    """
    res = []
    for h in s:
        # If h is in c, it is deleted (skipped).
        if not existsb(lambda x: x == h, c):
            res.append(h)
    return res

def is_pal_impl(s):
    """
    Checks if a list is equal to its reverse.
    Equivalent to Coq's is_pal_impl.
    """
    # rev s in Coq is s[::-1] in Python for lists.
    return list_eqb(lambda x, y: x == y, s, s[::-1])

def del_and_pal_impl(s, c):
    """
    Combines delete_chars_impl and is_pal_impl.
    Equivalent to Coq's del_and_pal_impl.
    """
    r = delete_chars_impl(s, c)
    return (r, is_pal_impl(r))

def reverse_delete(s, c):
    """
    Converts strings to lists, calls del_and_pal_impl, and converts the result back to a string.
    Equivalent to Coq's reverse_delete.
    """
    ls = list(s)
    lc = list(c)
    r, b = del_and_pal_impl(ls, lc)
    return ("".join(r), b)

def problem_112_pre(s, c):
    """
    Precondition: s and c only contain lowercase letters (ASCII 97-122).
    Equivalent to Coq's problem_112_pre.
    """
    ls = [ord(ch) for ch in s]
    lc = [ord(ch) for ch in c]
    cond_s = all(97 <= n <= 122 for n in ls)
    cond_c = all(97 <= n <= 122 for n in lc)
    return cond_s and cond_c

def problem_112_spec(s, c, output):
    """
    Specification: output must match the result of reverse_delete(s, c).
    Equivalent to Coq's problem_112_spec.
    """
    return output == reverse_delete(s, c)

def _impl(s, c):
    ss = "".join(filter(lambda ch: ch not in c, s))
    return ss, ss == ss[::-1]

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_112_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_112_spec(*input, output))

def reverse_delete(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
