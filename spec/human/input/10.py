def palindrome(s: str) -> bool:
    return s == s[::-1]

def make_palindrome(input_str: str) -> str:
    if not input_str:
        return ""
    for i in range(len(input_str)):
        if palindrome(input_str[i:]):
            return input_str + input_str[:i][::-1]
    return input_str + input_str[::-1]

def problem_10_pre() -> bool:
    return True

def problem_10_spec(input_str: str, output: str) -> bool:
    if not output.startswith(input_str):
        return False
    if not palindrome(output):
        return False

    # Verify the universal quantifier: 
    # forall p, (prefix(input, p) /\ palindrome(p)) -> length(output) <= length(p)
    # We do this by checking if there exists any valid palindrome p starting with input_str
    # that is strictly shorter than output.
    for i in range(len(input_str) + 1):
        if palindrome(input_str[i:]):
            # Construct a valid palindrome p that starts with input_str
            p = input_str + input_str[:i][::-1]
            
            # If we find a valid p that is shorter than output, the universal condition fails
            if len(output) > len(p):
                return False

    return True
