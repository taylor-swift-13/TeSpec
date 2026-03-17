
def precondition(input) -> bool:
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    return all(c in '[]' for c in string)

def postcondition(input, output) -> bool:
    if not isinstance(output, bool):
        return False
    string = input[0]
    i1 = string.find('[')
    i2 = string.find('[', i1 + 1) if i1 != -1 else -1
    j1 = string.rfind(']')
    j2 = string.rfind(']', 0, j1) if j1 != -1 else -1
    expected = (i2 != -1 and j2 != -1 and i2 < j2)
    return output == expected

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
