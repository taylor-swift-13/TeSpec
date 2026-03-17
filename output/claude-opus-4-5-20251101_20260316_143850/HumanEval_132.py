
def precondition(args):
    if len(args) != 1:
        return False
    string = args[0]
    if not isinstance(string, str):
        return False
    for char in string:
        if char != '[' and char != ']':
            return False
    return True

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    string = args[0]
    if output:
        open_count = 0
        max_depth = 0
        for char in string:
            if char == '[':
                open_count += 1
                if open_count > max_depth:
                    max_depth = open_count
            elif char == ']':
                if open_count > 0:
                    open_count -= 1
        if max_depth < 2:
            return False
    return True

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
