from typing import List

def precondition(input):
    numbers_str = input[0]
    if not isinstance(numbers_str, str):
        return False
    if numbers_str == "":
        return True
    words = numbers_str.split()
    valid = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
    for w in words:
        if w not in valid:
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    numbers_str = input[0]
    if numbers_str == "":
        return output == ""
    words = numbers_str.split()
    valid = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
    mapping = {"zero": 0, "one": 1, "two": 2, "three": 3, "four": 4,
               "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9}
    # check that output contains same multiset of words
    in_words = words
    out_words = output.split()
    if sorted(in_words) != sorted(out_words):
        return False
    # check that output words are sorted by numeric value
    for i in range(len(out_words) - 1):
        if mapping[out_words[i]] > mapping[out_words[i + 1]]:
            return False
    return True

def _impl(numbers: str) -> str:
    """Input is a space-delimited string of numberals from 'zero' to 'nine'.
    Valid choices are 'zero', 'one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight' and 'nine'.
    Return the string with numbers sorted from smallest to largest
    'one three five'"""
    to_int = {'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9}

    if numbers == "": return ""
    return " ".join(sorted(numbers.split(" "), key=lambda n: to_int[n]))

def sort_numbers(numbers: str) -> str:
    _input = (numbers,)
    assert precondition(_input)
    _output = _impl(numbers)
    assert postcondition(_input, _output)
    return _output
