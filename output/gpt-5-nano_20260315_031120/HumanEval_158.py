
def precondition(input) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    words = input[0]
    if not isinstance(words, list) or len(words) == 0:
        return False
    for w in words:
        if not isinstance(w, str):
            return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    words = input[0]
    if not isinstance(words, list) or len(words) == 0:
        return False
    if not isinstance(output, str):
        return False
    max_unique = -1
    best = None
    for w in words:
        uniq = len(set(w))
        if uniq > max_unique:
            max_unique = uniq
            best = w
        elif uniq == max_unique:
            if best is None or w < best:
                best = w
    return output == best

def _impl(words):
    """Write a function that accepts a list of strings.
    The list contains different words. Return the word with maximum number
    of unique characters. If multiple strings have maximum number of unique
    characters, return the one which comes first in lexicographical order.

    find_max(["name", "of", "string"]) == "string"
    find_max(["name", "enam", "game"]) == "enam"
    find_max(["aaaaaaa", "bb" ,"cc"]) == ""aaaaaaa""""
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
