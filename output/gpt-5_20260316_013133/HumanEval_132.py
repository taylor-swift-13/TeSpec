
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
    if not isinstance(output, bool):
        return False
    s = input[0]
    n = len(s)
    # Need at least 4 characters to form "[[]]"
    if n < 4:
        return output is False
    # Precompute number of ']' strictly after each position
    close_after = [0] * n
    count = 0
    for i in range(n - 1, -1, -1):
        close_after[i] = count
        if s[i] == ']':
            count += 1
    seen_open = 0
    exists_nested_subseq = False
    for j, ch in enumerate(s):
        if ch == '[':
            if seen_open >= 1 and close_after[j] >= 2:
                exists_nested_subseq = True
                break
            seen_open += 1
    return output is exists_nested_subseq

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
