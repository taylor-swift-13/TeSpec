
def precondition(input_args):
    if not isinstance(input_args, tuple) or len(input_args) != 1:
        return False
    words = input_args[0]
    return isinstance(words, list) and all(isinstance(w, str) for w in words)

def postcondition(input_args, output):
    words = input_args[0]
    if not words:
        return output is None
    if output not in words:
        return False
    
    max_unique_count = max(len(set(w)) for w in words)
    if len(set(output)) != max_unique_count:
        return False
    
    for w in words:
        if len(set(w)) == max_unique_count:
            if w < output:
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
