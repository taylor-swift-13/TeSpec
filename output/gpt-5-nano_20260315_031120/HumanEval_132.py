
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    for ch in s:
        if ch not in '[]':
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    opens_seen = 0
    closes_remaining = s.count(']')
    expected = False
    for ch in s:
        if ch == ']':
            closes_remaining -= 1
        elif ch == '[':
            if opens_seen >= 1 and closes_remaining >= 2:
                expected = True
                break
            opens_seen += 1
    observed = bool(output)
    return observed == expected

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
