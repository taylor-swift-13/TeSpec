
def precondition(input):
    if len(input) != 1:
        return False
    string = input[0]
    if not isinstance(string, str):
        return False
    if not all(c in '[]' for c in string):
        return False
    return True

def postcondition(input, output):
    string = input[0]
    if not isinstance(output, bool):
        return False
    # Verify by computing the expected result
    # A valid subsequence with nesting means there exist indices i<j<k<l
    # such that string[i]='[', string[j]='[', string[k]=']', string[l]=']'
    # More practically: check if any prefix has opening count >= 2 while
    # tracking proper nesting
    
    # We check: scan left to right tracking depth of nesting.
    # If depth ever reaches 2, there's nesting. But we need to be careful
    # about the "valid subsequence" aspect.
    
    # Actually, let's think about it differently:
    # We need to find at least one pair of properly nested brackets inside
    # another pair. This means we need to find a substring pattern where
    # the maximum nesting depth (tracking open/close properly) reaches >= 2.
    
    # Count max nesting depth using a stack-like approach, but reset on invalid
    # Actually, the examples show:
    # '[]]]]]]][[[[[]' -> False: the [] at start has depth 1, the [[[[[] at end
    #   has depth going up but only one ] to close
    # '[[]][[' -> True: [[ ]] gives depth 2
    
    # Approach: track opening count, when we see ], decrement.
    # If at any point before decrementing the count was >= 2, we found nesting.
    # But we also need at least one closing bracket to match.
    
    max_depth = 0
    depth = 0
    found_nested = False
    for c in string:
        if c == '[':
            depth += 1
            if depth > max_depth:
                max_depth = depth
        elif c == ']':
            if depth >= 2:
                found_nested = True
            if depth > 0:
                depth -= 1
    
    expected = found_nested
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
