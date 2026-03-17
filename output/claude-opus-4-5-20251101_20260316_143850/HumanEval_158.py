
def precondition(input):
    # Check that input is a tuple with exactly one element
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    
    words = input[0]
    
    # Check that words is a list
    if not isinstance(words, list):
        return False
    
    # Check that the list is not empty
    if len(words) == 0:
        return False
    
    # Check that all elements are strings
    for word in words:
        if not isinstance(word, str):
            return False
    
    return True


def postcondition(input, output):
    # First verify precondition
    if not precondition(input):
        return False
    
    words = input[0]
    
    # Output must be a string
    if not isinstance(output, str):
        return False
    
    # Output must be one of the words in the input list
    if output not in words:
        return False
    
    # Calculate the maximum number of unique characters
    max_unique = max(len(set(word)) for word in words)
    
    # Output must have the maximum number of unique characters
    if len(set(output)) != max_unique:
        return False
    
    # Get all words with maximum unique characters
    candidates = [word for word in words if len(set(word)) == max_unique]
    
    # Output must be the lexicographically smallest among candidates
    if output != min(candidates):
        return False
    
    return True

def _impl(words):
    """Write a function that accepts a list of strings.
    The list contains different words. Return the word with maximum number
    of unique characters. If multiple strings have maximum number of unique
    characters, return the one which comes first in lexicographical order.

    find_max(["name", "of", "string"]) == "string"
    find_max(["name", "enam", "game"]) == "enam"
    find_max(["aaaaaaa", "bb" ,"cc"]) == ""aaaaaaa"
    """
    mx_ch_cnt, ans = 0, ""
    for word in words:
        ch_cnt = len(set(word)) 
        if ch_cnt > mx_ch_cnt or (ch_cnt == mx_ch_cnt and word < ans):
            mx_ch_cnt, ans = ch_cnt, word
    return ans

def find_max(words):
    _input = (words,)
    assert precondition(_input)
    _output = _impl(words)
    assert postcondition(_input, _output)
    return _output
