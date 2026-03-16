
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    # empty or all-whitespace string is allowed
    if s.strip() == "":
        return True
    # split on whitespace and require each token is a single lowercase letter a-z
    tokens = s.split()
    for t in tokens:
        if not isinstance(t, str):
            return False
        if len(t) != 1:
            return False
        ch = t
        if not ('a' <= ch <= 'z'):
            return False
    return True

def postcondition(input, output):
    # If precondition is not met, don't enforce postcondition here
    if not precondition(input):
        return True
    s = input[0]
    # For empty input string, expect empty dict
    if s.strip() == "":
        return isinstance(output, dict) and output == {}
    # Compute expected counts
    tokens = s.split()
    from collections import Counter
    counts = Counter(tokens)
    if not counts:
        expected = {}
    else:
        maxc = max(counts.values())
        expected = {k: v for k, v in counts.items() if v == maxc}
    # output must be a dict mapping single lowercase-letter strings to ints equal to expected
    if not isinstance(output, dict):
        return False
    # Validate keys and values types and nonnegativity
    for k, v in output.items():
        if not isinstance(k, str) or len(k) != 1 or not ('a' <= k <= 'z'):
            return False
        if not isinstance(v, int) or v < 0:
            return False
    return output == expected

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
