from typing import List

def join_with_space(l):
    return " ".join(l)

def valid_word(s):
    return s in [
        "zero", "one", "two", "three", "four", 
        "five", "six", "seven", "eight", "nine"
    ]

def val_of(s):
    mapping = {
        "zero": 0,
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    }
    return mapping.get(s, 0)

def sort_numbers_spec(numbers, result):
    if numbers == "" and result == "":
        return True
    if numbers == "":
        return False
        
    l = numbers.split(" ")
    if join_with_space(l) != numbers:
        return False
        
    for w in l:
        if not valid_word(w):
            return False
            
    l_prime = sorted(l, key=val_of)
    return result == join_with_space(l_prime)

def _impl(numbers: str) -> str:
    to_int = {'zero': 0, 'one': 1, 'two': 2, 'three': 3, 'four': 4, 'five': 5, 'six': 6, 'seven': 7, 'eight': 8, 'nine': 9}
    if numbers == "": return ""
    return " ".join(sorted(numbers.split(" "), key=lambda n: to_int[n]))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(sort_numbers_spec(*input, output))

def sort_numbers(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
