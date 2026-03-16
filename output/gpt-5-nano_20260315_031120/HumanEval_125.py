
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    txt = input[0]
    if not isinstance(txt, str):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    txt = input[0]
    has_whitespace = any(ch.isspace() for ch in txt)
    if has_whitespace:
        expected = txt.split()
    elif ',' in txt:
        expected = txt.split(',')
    else:
        count = 0
        for ch in txt:
            if 'a' <= ch <= 'z':
                if (ord(ch) - ord('a')) % 2 == 1:
                    count += 1
        expected = count
    return output == expected

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
