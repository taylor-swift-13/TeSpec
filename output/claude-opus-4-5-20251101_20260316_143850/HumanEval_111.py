
def precondition(args):
    if len(args) != 1:
        return False
    test = args[0]
    if not isinstance(test, str):
        return False
    # Allow empty string
    if test == '':
        return True
    # Check that string contains only lowercase letters and spaces
    for char in test:
        if char != ' ' and not ('a' <= char <= 'z'):
            return False
    return True


def postcondition(args, output):
    test = args[0]
    
    # Output must be a dictionary
    if not isinstance(output, dict):
        return False
    
    # Handle empty string case
    if test == '':
        return output == {}
    
    # Split the string and count letters
    parts = test.split()
    if len(parts) == 0:
        return output == {}
    
    # Count occurrences of each letter
    counts = {}
    for part in parts:
        if part:  # non-empty part
            if part in counts:
                counts[part] = counts[part] + 1
            else:
                counts[part] = 1
    
    if len(counts) == 0:
        return output == {}
    
    # Find the maximum count
    max_count = max(counts.values())
    
    # Build expected output: all letters with max count
    expected = {}
    for letter, count in counts.items():
        if count == max_count:
            expected[letter] = count
    
    # Check that output matches expected
    if len(output) != len(expected):
        return False
    
    for key, value in expected.items():
        if key not in output:
            return False
        if output[key] != value:
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
