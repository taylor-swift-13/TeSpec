
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    txt = input[0]
    if not isinstance(txt, str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False

    if any(ch.isspace() for ch in s):
        expected = s.split()
    elif ',' in s:
        expected = s.split(',')
    else:
        count = 0
        base = ord('a')
        for ch in s:
            if 'a' <= ch <= 'z':
                if (ord(ch) - base) % 2 == 1:
                    count += 1
        expected = count

    if isinstance(expected, list):
        return isinstance(output, list) and output == expected
    else:
        return isinstance(output, int) and output == expected

def _impl(txt):
    """
    Given a string of words, return a list of words split on whitespace, if no whitespaces exists in the text you
    should split on commas ',' if no commas exists you should return the number of lower-case letters with odd order in the
    alphabet, ord('a') = 0, ord('b') = 1, ... ord('z') = 25
    Examples
    split_words("Hello world!") ➞ ["Hello", "world!"]
    split_words("Hello,world!") ➞ ["Hello", "world!"]
    split_words("abcdef") == 3
    """
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
