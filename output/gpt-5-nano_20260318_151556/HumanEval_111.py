
def precondition(input):
    # input should be a tuple of exactly one element: the string
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    tokens = s.split()
    for t in tokens:
        if not isinstance(t, str):
            return False
        if len(t) != 1:
            return False
        if not ('a' <= t <= 'z'):
            return False
    return True

def postcondition(input, output):
    # Validate input shape and types
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    tokens = s.split()
    # output must be a dict mapping single lowercase letters to non-negative ints
    if not isinstance(output, dict):
        return False
    for k, v in output.items():
        if not isinstance(k, str) or len(k) != 1 or not ('a' <= k <= 'z'):
            return False
        if not isinstance(v, int) or v < 0:
            return False
    # Compute expected output
    if len(tokens) == 0:
        expected = {}
    else:
        from collections import Counter
        counts = Counter(tokens)
        max_count = max(counts.values()) if counts else 0
        expected = {ch: c for ch, c in counts.items() if c == max_count}
    return output == expected

def _impl(test):
    """
    Given a string representing a space separated lowercase letters, return a dictionary
    of the letter with the most repetition and containing the corresponding count.
    If several letters have the same occurrence, return all of them.

    Example:
    histogram('a b c') == {'a': 1, 'b': 1, 'c': 1}
    histogram('a b b a') == {'a': 2, 'b': 2}
    histogram('a b c a b') == {'a': 2, 'b': 2}
    histogram('b b b b a') == {'b': 4}
    histogram('') == {}
    """
    if test == "": return {}    
    count, ans = dict(), dict()
    for word in test.split(" "):
        if word != "":
            if word not in count: count[word] = 0
            count[word] += 1
    mx = max(list(count.values()))
    for ch, c in count.items():
        if c == mx:
            ans[ch] = c
    return ans

def histogram(test):
    _input = (test,)
    assert precondition(_input)
    _output = _impl(test)
    assert postcondition(_input, _output)
    return _output
