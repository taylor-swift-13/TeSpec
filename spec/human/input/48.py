def problem_48_pre(input: str) -> bool:
    return True

def problem_48_spec(input: str, output: bool) -> bool:
    is_palindrome = (input == input[::-1])
    return output == is_palindrome
