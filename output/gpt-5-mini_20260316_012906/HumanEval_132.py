
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    for ch in s:
        if ch not in "[]":
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    n = len(s)
    expected = False
    # Look for indices i<j<k<l with s[i]=='[', s[j]=='[', s[k]==']', s[l]==']'
    for i in range(n):
        if s[i] != '[':
            continue
        for j in range(i+1, n):
            if s[j] != '[':
                continue
            for k in range(j+1, n):
                if s[k] != ']':
                    continue
                for l in range(k+1, n):
                    if s[l] != ']':
                        continue
                    expected = True
                    break
                if expected:
                    break
            if expected:
                break
        if expected:
            break
    return isinstance(output, bool) and output == expected

def _impl(string):
    """Create a function that takes a string as input which contains only square brackets.
    The function should return True if and only if there is a valid subsequence of brackets 
    where at least one bracket in the subsequence is nested.

    is_nested('[[]]') ➞ True
    is_nested('[]]]]]]][[[[[]') ➞ False
    is_nested('[][]') ➞ False
    is_nested('[]') ➞ False
    is_nested('[[][]]') ➞ True
    is_nested('[[]][[') ➞ True"""
    for i in range(len(string)):
        if string[i] == "]": continue
        cnt, max_nest = 0, 0
        for j in range(i, len(string)):
            if string[j] == "[":
                cnt += 1
            else:
                cnt -= 1
            max_nest = max(max_nest, cnt)
            if cnt == 0:
                if max_nest >= 2:
                    return True
                break
    return False

def is_nested(string):
    _input = (string,)
    assert precondition(_input)
    _output = _impl(string)
    assert postcondition(_input, _output)
    return _output
