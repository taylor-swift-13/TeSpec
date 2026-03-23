def max_depth_aux(g: str, current_depth: int, max_seen: int) -> int:
    """
    Calculates the maximum nesting depth of a single group of parentheses.
    """
    if not g:
        return max_seen
    
    h = g[0]
    t = g[1:]
    
    if h == '(':
        new_depth = current_depth + 1
        return max_depth_aux(t, new_depth, max(max_seen, new_depth))
    elif h == ')':
        # Nat.pred in Coq: pred(0) = 0
        new_depth = max(0, current_depth - 1)
        return max_depth_aux(t, new_depth, max_seen)
    else:
        # Ignore other characters
        return max_depth_aux(t, current_depth, max_seen)

def MaxDepth(g: str) -> int:
    """
    Wrapper for max_depth_aux starting with 0 depth.
    """
    return max_depth_aux(g, 0, 0)

def SplitOnSpaces(S: str) -> list:
    """
    Splits a string into a list of strings based on spaces, 
    mimicking the Coq SplitOnSpaces_aux logic.
    """
    # The Coq implementation splits by space and ignores empty groups
    # resulting from multiple spaces or leading/trailing spaces.
    parts = S.split(' ')
    return [p for p in parts if p != '']

def parse_nested_parens_impl(input_str: str) -> list:
    """
    The core logic: split the input and map MaxDepth over the groups.
    """
    groups = SplitOnSpaces(input_str)
    return [MaxDepth(g) for g in groups]

def is_paren_or_space(c: str) -> bool:
    """
    Checks if a character is '(', ')' or ' '.
    """
    return c in ('(', ')', ' ')

def ForallChars(input_str: str) -> bool:
    """
    Checks if all characters in the string satisfy is_paren_or_space.
    """
    return all(is_paren_or_space(c) for c in input_str)

def IsBalanced_aux(l: str, count: int) -> bool:
    """
    Checks if the parentheses in the string are balanced.
    """
    if not l:
        return count == 0
    
    h = l[0]
    t = l[1:]
    
    if h == '(':
        return IsBalanced_aux(t, count + 1)
    elif h == ')':
        if count == 0:
            return False
        return IsBalanced_aux(t, count - 1)
    else:
        # Ignore other characters (like spaces)
        return IsBalanced_aux(t, count)

def IsBalanced(l: str) -> bool:
    """
    Wrapper for IsBalanced_aux starting with 0 count.
    """
    return IsBalanced_aux(l, 0)

def problem_6_pre(input_str: str) -> bool:
    """
    Precondition: All characters are valid and parentheses are balanced.
    """
    return ForallChars(input_str) and IsBalanced(input_str)

def problem_6_spec(input_str: str, output: list) -> bool:
    """
    Specification: The output must match the result of the implementation.
    """
    return output == parse_nested_parens_impl(input_str)

def parse_nested_parens(input_str: str) -> list:
    """
    The main function as described in the docstring.
    """
    return parse_nested_parens_impl(input_str)

# Example usage:
# print(parse_nested_parens('(()()) ((())) () ((())()())'))
# Output: [2, 3, 1, 3]
