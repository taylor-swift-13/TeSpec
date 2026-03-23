def contains_substring(s, sub):
    """
    Checks if 'sub' is a substring of 's'.
    Implements the logic of the Coq Fixpoint contains_substring.
    """
    return sub in s

def filter_by_substring_impl(input, sub):
    """
    Filters the input list, keeping only strings that contain 'sub'.
    Implements the logic of the Coq Fixpoint filter_by_substring_impl.
    """
    return [h for h in input if contains_substring(h, sub)]

def _orig_problem_7_pre():
    """
    Pre-condition for problem 7.
    Always returns True as per Coq definition.
    """
    return True

def _orig_problem_7_spec(input, output, sub):
    """
    Specification for problem 7.
    Checks if 'output' is the result of filtering 'input' by 'sub'.
    """
    return output == filter_by_substring_impl(input, sub)

def problem_7_pre(strings, substring):
    return bool(_orig_problem_7_pre())

def problem_7_spec(strings, substring, output):
    return bool(_orig_problem_7_spec(strings, substring, output))
