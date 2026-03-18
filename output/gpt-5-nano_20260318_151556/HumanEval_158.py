
def precondition(input):
    # input is a tuple of positional arguments
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
    # input is the same tuple as used by precondition
    if not isinstance(output, str):
        return False
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    words = input[0]
    if not isinstance(words, list) or len(words) == 0:
        return False
    for w in words:
        if not isinstance(w, str):
            return False
    best_word = None
    best_count = -1
    for w in words:
        cnt = len(set(w))
        if cnt > best_count:
            best_count = cnt
            best_word = w
        elif cnt == best_count:
            if w < best_word:
                best_word = w
    return output == best_word

def _impl(words):
    """
    Write a function that accepts a list of strings.
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
