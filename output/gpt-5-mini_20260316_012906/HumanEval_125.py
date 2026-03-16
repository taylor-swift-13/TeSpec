
def precondition(input):
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return True
    s = input[0]
    # If any whitespace exists, should split on whitespace (like str.split())
    if any(ch.isspace() for ch in s):
        return isinstance(output, list) and all(isinstance(x, str) for x in output) and output == s.split()
    # If no whitespace but contains commas, split on commas
    if ',' in s:
        return isinstance(output, list) and all(isinstance(x, str) for x in output) and output == s.split(',')
    # Otherwise return the count of lowercase letters with odd order in alphabet
    count = sum(1 for ch in s if 'a' <= ch <= 'z' and ((ord(ch) - ord('a')) % 2 == 1))
    return isinstance(output, int) and output == count

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
