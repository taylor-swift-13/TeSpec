
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    test = input[0]
    if not isinstance(test, str):
        return False
    for char in test:
        if not (char.islower() or char.isspace()):
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, dict):
        return False
    test = input[0]
    if test == "":
        return output == {}
    letters = [c for c in test if c.islower()]
    if not letters:
        return output == {}
    counts = {}
    for c in letters:
        counts[c] = counts.get(c, 0) + 1
    max_count = max(counts.values()) if counts else 0
    expected = {k: v for k, v in counts.items() if v == max_count}
    if expected != output:
        return False
    for v in output.values():
        if not isinstance(v, int) or v <= 0:
            return False
    for k in output:
        if not isinstance(k, str) or not k.islower():
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
