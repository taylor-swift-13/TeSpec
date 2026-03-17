
def flip_case(string: str) -> str:
    """For a given string, flip lowercase characters to uppercase and uppercase to lowercase.
    'hELLO'"""
    return "".join(map(lambda x: x.swapcase(), string))
