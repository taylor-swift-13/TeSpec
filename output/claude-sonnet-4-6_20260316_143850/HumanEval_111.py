
def precondition(args):
    if len(args) != 1:
        return False
    test = args[0]
    if not isinstance(test, str):
        return False
    if test == '':
        return True
    parts = test.split(' ')
    for part in parts:
        if len(part) != 1:
            return False
        if not part.islower():
            return False
    return True


def postcondition(args, output):
    if not isinstance(output, dict):
        return False
    test = args[0]
    if test == '':
        return output == {}
    parts = test.split(' ')
    if len(output) == 0:
        return False
    counts = {}
    for p in parts:
        counts[p] = counts.get(p, 0) + 1
    max_count = max(counts.values())
    for key, val in output.items():
        if not isinstance(key, str):
            return False
        if val != max_count:
            return False
        if counts.get(key, 0) != max_count:
            return False
    for key, val in counts.items():
        if val == max_count:
            if key not in output:
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
