
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    words = input[0]
    if not isinstance(words, (list, tuple)):
        return False
    for w in words:
        if not isinstance(w, str):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    words = input[0]
    # If there are no words, accept any string output (implementation-defined)
    if len(words) == 0:
        return isinstance(output, str)
    if not isinstance(output, str):
        return False
    # output must be one of the input words
    if output not in words:
        return False
    # compute maximum number of unique characters among words
    try:
        uniques = [len(set(w)) for w in words]
    except Exception:
        return False
    if len(set(output)) != max(uniques):
        return False
    # if other words tie with the same max unique count, output must be
    # the lexicographically smallest among those tied words
    maxu = max(uniques)
    tied = [w for w, u in zip(words, uniques) if u == maxu]
    if not tied:
        return False
    # find lexicographically smallest tied word
    smallest = min(tied)
    return output == smallest

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
