
def precondition(input):
    (txt,) = input
    return isinstance(txt, str)


def postcondition(input, output):
    (txt,) = input
    if ' ' in txt:
        return (
            isinstance(output, list)
            and all(isinstance(w, str) for w in output)
            and output == txt.split()
        )
    elif ',' in txt:
        return (
            isinstance(output, list)
            and all(isinstance(w, str) for w in output)
            and output == txt.split(',')
        )
    else:
        if not isinstance(output, int):
            return False
        count = sum(1 for c in txt if c.islower() and (ord(c) - ord('a')) % 2 == 1)
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
