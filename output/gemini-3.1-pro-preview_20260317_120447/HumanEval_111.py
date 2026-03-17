
def precondition(inputs: tuple) -> bool:
    return len(inputs) == 1 and isinstance(inputs[0], str)

def postcondition(inputs: tuple, output: dict) -> bool:
    test = inputs[0]
    if not isinstance(output, dict):
        return False
    
    parts = test.split()
    if not parts:
        return output == {}
    
    counts = {}
    for p in parts:
        counts[p] = counts.get(p, 0) + 1
        
    max_count = max(counts.values())
    expected = {k: v for k, v in counts.items() if v == max_count}
    
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
