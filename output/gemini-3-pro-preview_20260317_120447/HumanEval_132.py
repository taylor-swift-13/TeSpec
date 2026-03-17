
def precondition(args):
    if len(args) != 1:
        return False
    s = args[0]
    if not isinstance(s, str):
        return False
    return all(c == '[' or c == ']' for c in s)

def postcondition(args, output):
    s = args[0]
    if not isinstance(output, bool):
        return False
    
    # A valid subsequence with at least one nested bracket exists if and only if
    # there is a subsequence of the form '[[]]'.
    # This means there exist indices i < j < k < l such that
    # s[i] == '[', s[j] == '[', s[k] == ']', s[l] == ']'
    
    found = False
    n = len(s)
    for i in range(n):
        if s[i] == '[':
            for j in range(i + 1, n):
                if s[j] == '[':
                    for k in range(j + 1, n):
                        if s[k] == ']':
                            for l in range(k + 1, n):
                                if s[l] == ']':
                                    found = True
                                    break
                        if found: break
                if found: break
        if found: break
        
    return output == found

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
