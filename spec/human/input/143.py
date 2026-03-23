def has_divisor_from(n, d):
    while True:
        if d == 0:
            return False
        if d == 1:
            return False
        if n % d == 0:
            return True
        d -= 1

def is_prime_bool(n):
    if n == 0 or n == 1:
        return False
    return not has_divisor_from(n, n - 1)

def split_words(s):
    res = []
    cur = []
    for h in s:
        if h == ' ':
            if cur:
                res.append(cur)
                cur = []
        else:
            cur.append(h)
    if cur:
        res.append(cur)
    return res

def join_words(ws):
    if not ws:
        return []
    if len(ws) == 1:
        return ws[0]
    return ws[0] + [' '] + join_words(ws[1:])

def words_in_sentence_impl(sentence):
    words = split_words(list(sentence))
    sel = [w for w in words if is_prime_bool(len(w))]
    return "".join(join_words(sel))

def _orig_problem_143_pre(sentence):
    l = len(sentence)
    if not 1 <= l <= 100:
        return False
    for c in sentence:
        n = ord(c)
        if not (c == ' ' or 65 <= n <= 90 or 97 <= n <= 122):
            return False
    return True

def _orig_problem_143_spec(sentence, output):
    return output == words_in_sentence_impl(sentence)

def problem_143_pre(sentence):
    return bool(_orig_problem_143_pre(sentence))

def problem_143_spec(sentence, output):
    return bool(_orig_problem_143_spec(sentence, output))
