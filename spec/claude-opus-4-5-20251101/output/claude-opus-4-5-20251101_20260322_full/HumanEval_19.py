from typing import List

from collections import Counter

def word_to_nat(s):
    """
    Maps a string word ("zero", "one", ..., "nine") to its corresponding natural number.
    Returns None if the word is not a valid number word.
    """
    mapping = {
        "zero": 0, "one": 1, "two": 2, "three": 3, "four": 4,
        "five": 5, "six": 6, "seven": 7, "eight": 8, "nine": 9
    }
    return mapping.get(s)

def valid_number_word(s):
    """
    Checks if a string is a valid number word.
    """
    return word_to_nat(s) is not None

def all_valid_words(words):
    """
    Checks if all words in a list are valid number words.
    """
    return all(valid_number_word(w) for w in words)

def get_nat(s):
    """
    Returns the natural number value of a word, or 0 if the word is invalid.
    """
    val = word_to_nat(s)
    return val if val is not None else 0

def sorted_by_value(words):
    """
    Checks if a list of words is sorted by their numeric values in non-decreasing order.
    """
    values = [get_nat(w) for w in words]
    for i in range(len(values) - 1):
        if values[i] > values[i+1]:
            return False
    return True

def is_permutation(l1, l2):
    """
    Checks if two lists of strings are permutations of each other.
    """
    return Counter(l1) == Counter(l2)

def split_by_space(s):
    """
    Splits a string into a list of words by a single space character.
    Returns an empty list for an empty string.
    """
    if s == "":
        return []
    return s.split(' ')

def join_by_space(words):
    """
    Joins a list of words into a single string separated by spaces.
    """
    return " ".join(words)

def sort_numbers_spec(input, output):
    """
    Specification for sorting number words in a string.
    Returns True if the output string correctly represents the sorted version of the input string,
    according to the rules defined in the Coq specification.
    """
    input_words = split_by_space(input)
    output_words = split_by_space(output)
    
    # (input = EmptyString -> output = EmptyString)
    cond1 = True
    if input == "":
        cond1 = (output == "")
        
    # (input <> EmptyString -> all_valid_words input_words -> 
    #  is_permutation input_words output_words /\ sorted_by_value output_words)
    cond2 = True
    if input != "":
        if all_valid_words(input_words):
            cond2 = is_permutation(input_words, output_words) and \
                    sorted_by_value(output_words)
            
    return cond1 and cond2

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
