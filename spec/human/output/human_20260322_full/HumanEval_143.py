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

def problem_143_pre(sentence):
    l = len(sentence)
    if not (1 <= l <= 100):
        return False
    for c in sentence:
        n = ord(c)
        if not (c == ' ' or (65 <= n <= 90) or (97 <= n <= 122)):
            return False
    return True

def problem_143_spec(sentence, output):
    return output == words_in_sentence_impl(sentence)

def _impl(sentence):
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    return " ".join(list(filter(lambda word: is_prime(len(word)), sentence.split(" "))))

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_143_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_143_spec(*input, output))

def words_in_sentence(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
