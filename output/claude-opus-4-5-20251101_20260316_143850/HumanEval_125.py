
def precondition(input):
    if len(input) != 1:
        return False
    txt = input[0]
    if not isinstance(txt, str):
        return False
    return True

def postcondition(input, output):
    txt = input[0]
    
    # Check if whitespace exists in text
    has_whitespace = ' ' in txt or '\t' in txt or '\n' in txt
    
    # Check if comma exists in text
    has_comma = ',' in txt
    
    if has_whitespace:
        # Should return list of words split on whitespace
        if not isinstance(output, list):
            return False
        if not all(isinstance(w, str) for w in output):
            return False
        # Verify the split is correct
        expected = txt.split()
        return output == expected
    elif has_comma:
        # Should return list of words split on commas
        if not isinstance(output, list):
            return False
        if not all(isinstance(w, str) for w in output):
            return False
        # Verify the split is correct
        expected = txt.split(',')
        return output == expected
    else:
        # Should return count of lowercase letters with odd order in alphabet
        if not isinstance(output, int):
            return False
        # Count lowercase letters with odd order (b=1, d=3, f=5, h=7, j=9, l=11, n=13, p=15, r=17, t=19, v=21, x=23, z=25)
        count = 0
        for char in txt:
            if char.islower():
                order = ord(char) - ord('a')
                if order % 2 == 1:
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
