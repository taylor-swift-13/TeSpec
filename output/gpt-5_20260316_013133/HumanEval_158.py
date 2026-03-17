
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    words = input[0]
    if not isinstance(words, list):
        return False
    if len(words) == 0:
        return False
    for w in words:
        if not isinstance(w, str):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    words = input[0]
    if not isinstance(output, str):
        return False
    if output not in words:
        return False
    def uniq_count(s):
        return len(set(s))
    max_count = max(uniq_count(w) for w in words)
    tied = [w for w in words if uniq_count(w) == max_count]
    expected = min(tied)
    return output == expected

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
