
def precondition(input):
    s = input[0]
    return isinstance(s, str) and all(c in '[]' for c in s)

def postcondition(input, output):
    s = input[0]
    
    def has_nested(string):
        stack = []
        for char in string:
            if char == '[':
                stack.append('[')
            elif char == ']':
                if not stack:
                    return False
                stack.pop()
        
        # Check for nesting: a nested structure exists if we find '[['
        # or if a pair is closed while another is already open.
        depth = 0
        for char in string:
            if char == '[':
                depth += 1
                if depth >= 2:
                    return True
            else:
                depth = max(0, depth - 1)
        return False

    return output == has_nested(s)

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
