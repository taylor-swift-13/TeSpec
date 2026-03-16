from typing import List

def precondition(input):
    try:
        if not isinstance(input, tuple) or len(input) != 1:
            return False
        numbers = input[0]
        if not isinstance(numbers, str):
            return False
        if numbers.strip() == "":
            return True
        allowed = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
        tokens = [t for t in numbers.split(" ") if t != ""]
        for t in tokens:
            if t not in allowed:
                return False
        return True
    except Exception:
        return False

def postcondition(input, output):
    try:
        if not precondition(input):
            return True
        if not isinstance(output, str):
            return False
        numbers = input[0]
        allowed = {"zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"}
        order = {"zero":0, "one":1, "two":2, "three":3, "four":4, "five":5, "six":6, "seven":7, "eight":8, "nine":9}
        in_tokens = [t for t in numbers.split(" ") if t != ""]
        out_tokens = [t for t in output.split(" ") if t != ""]
        for t in out_tokens:
            if t not in allowed:
                return False
        in_counts = {}
        for t in in_tokens:
            in_counts[t] = in_counts.get(t, 0) + 1
        out_counts = {}
        for t in out_tokens:
            out_counts[t] = out_counts.get(t, 0) + 1
        if in_counts != out_counts:
            return False
        out_vals = [order[t] for t in out_tokens]
        for i in range(1, len(out_vals)):
            if out_vals[i-1] > out_vals[i]:
                return False
        return True
    except Exception:
        return False

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
