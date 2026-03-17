
def precondition(input):
    words = input[0]
    return isinstance(words, list) and all(isinstance(w, str) for w in words) and len(words) > 0

def postcondition(input, output):
    words = input[0]
    if output not in words:
        return False
    
    def count_unique(s):
        return len(set(s))
    
    target_unique = count_unique(output)
    
    for word in words:
        unique_count = count_unique(word)
        if unique_count > target_unique:
            return False
        if unique_count == target_unique:
            if word < output:
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
