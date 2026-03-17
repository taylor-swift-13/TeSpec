
def precondition(input_args):
    return isinstance(input_args[0], str)

def postcondition(input_args, output):
    test = input_args[0]
    if not isinstance(output, dict):
        return False
    
    words = test.split()
    if not words:
        return output == {}
    
    counts = {}
    for w in words:
        counts[w] = counts.get(w, 0) + 1
    
    max_val = max(counts.values())
    expected = {k: v for k, v in counts.items() if v == max_val}
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
