
def precondition(args):
    if len(args) != 1:
        return False
    string = args[0]
    if not isinstance(string, str):
        return False
    for ch in string:
        if ch not in '[]':
            return False
    return True

def postcondition(args, output):
    if not isinstance(output, bool):
        return False
    string = args[0]
    
    # Verify by checking if there exists a valid nested subsequence
    # A nested subsequence means we can find indices i < j < k < l such that
    # string[i] = '[', string[j] = '[', string[k] = ']', string[l] = ']'
    # and i < j < k < l (i.e., '[[]]' pattern as subsequence)
    
    # Count open brackets seen before each close bracket
    # If at any close bracket we have >= 2 open brackets accumulated,
    # and then find another close bracket after, we have nesting
    
    # Simple check: find if subsequence '[[]]' exists
    # Track minimum opens needed
    opens = 0
    found_nested = False
    # We need to find [[ before ]]
    # Track how many '[' we've seen, and if we see ']' when opens >= 2
    # then we need one more ']'
    
    # Actually let's just recompute expected output
    n = len(string)
    # dp approach: for each position track if we can form nested
    # A nested valid subsequence requires pattern like [[...]]
    # Count '[' up to each position, count ']' from each position
    
    open_count = 0
    close_counts = [0] * n
    # count ']' from right
    for i in range(n - 1, -1, -1):
        if i < n - 1:
            close_counts[i] = close_counts[i + 1]
        if string[i] == ']':
            close_counts[i] += 1
    
    expected = False
    open_count = 0
    for i in range(n):
        if string[i] == '[':
            open_count += 1
        elif string[i] == ']':
            # We need open_count >= 2 opens before this ']' and at least 1 more ']' after
            if open_count >= 2 and close_counts[i + 1] >= 1 if i + 1 < n else False:
                expected = True
                break
            open_count = max(0, open_count - 1)
    
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
