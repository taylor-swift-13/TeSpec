
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    tokens = s.split()
    # If no tokens, expect empty dict
    if len(tokens) == 0:
        return isinstance(output, dict) and len(output) == 0
    # Well-formed means tokens are single lowercase letters
    well_formed = all(isinstance(t, str) and len(t) == 1 and 'a' <= t <= 'z' for t in tokens)
    if not well_formed:
        return True
    # Compute frequencies
    freq = {}
    for t in tokens:
        freq[t] = freq.get(t, 0) + 1
    max_count = max(freq.values()) if freq else 0
    expected_keys = {k for k, v in freq.items() if v == max_count} if max_count > 0 else set()
    # Validate output
    if not isinstance(output, dict):
        return False
    if set(output.keys()) != expected_keys:
        return False
    for k, v in output.items():
        if not (isinstance(k, str) and len(k) == 1 and 'a' <= k <= 'z'):
            return False
        if not (isinstance(v, int) and v == max_count and v >= 1):
            return False
    return True

def _impl(test):
    """Given a string representing a space separated lowercase letters, return a dictionary
    of the letter with the most repetition and containing the corresponding count.
    If several letters have the same occurrence, return all of them.

    Example:
    histogram('a b c') == {'a': 1, 'b': 1, 'c': 1}
    histogram('a b b a') == {'a': 2, 'b': 2}
    histogram('a b c a b') == {'a': 2, 'b': 2}
    histogram('b b b b a') == {'b': 4}
    histogram('') == {}"""
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
