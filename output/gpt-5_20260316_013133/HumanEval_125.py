
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    txt = input[0]
    return isinstance(txt, str)


def postcondition(input, output):
    if not precondition(input):
        return True
    txt = input[0]
    has_ws = any(ch.isspace() for ch in txt)
    if has_ws:
        if not isinstance(output, list):
            return False
        if not all(isinstance(s, str) for s in output):
            return False
        return output == txt.split()
    if ',' in txt:
        if not isinstance(output, list):
            return False
        if not all(isinstance(s, str) for s in output):
            return False
        return output == txt.split(',')
    if not isinstance(output, int):
        return False
    count = 0
    for ch in txt:
        if 'a' <= ch <= 'z':
            if ((ord(ch) - ord('a')) % 2) == 1:
                count += 1
    return output == count

def _impl(txt):
    """Given a string of words, return a list of words split on whitespace, if no whitespaces exists in the text you
    should split on commas ',' if no commas exists you should return the number of lower-case letters with odd order in the
    alphabet, ord('a') = 0, ord('b') = 1, ... ord('z') = 25
    Examples
    split_words("Hello world!") ➞ ["Hello", "world!"]
    split_words("Hello,world!") ➞ ["Hello", "world!"]
    split_words("abcdef") == 3"""
    whitespace = tuple(' \n\r\t')
    if any([x in txt for x in whitespace]): return txt.split()
    if "," in txt: return txt.split(",")
    cnt = 0
    for ch in txt:
        if ch.islower() and (ord(ch) - ord("a")) % 2 == 1: cnt += 1
    return cnt

def split_words(txt):
    _input = (txt,)
    assert precondition(_input)
    _output = _impl(txt)
    assert postcondition(_input, _output)
    return _output
