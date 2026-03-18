
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    return isinstance(s, str)

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, str):
        return False

    i = 0
    j = 0
    n = len(s)
    m = len(output)

    while i < n:
        if s[i] == ' ':
            if j >= m or output[j] != ' ':
                return False
            i += 1
            j += 1
        else:
            i2 = i
            while i2 < n and s[i2] != ' ':
                i2 += 1
            word = s[i:i2]
            sorted_word = ''.join(sorted(word))
            if j + len(word) > m:
                return False
            if output[j: j + len(word)] != sorted_word:
                return False
            i = i2
            j += len(word)

    if j != m:
        return False
    return True

def _impl(s):
    """
    Write a function that takes a string and returns an ordered version of it.
    Ordered version of string, is a string where all words (separated by space)
    are replaced by a new word where all the characters arranged in
    ascending order based on ascii value.
    Note: You should keep the order of words and blank spaces in the sentence.

    For example:
    anti_shuffle('Hi') returns 'Hi'
    anti_shuffle('hello') returns 'ehllo'
    anti_shuffle('Hello World!!!') returns 'Hello !!!Wdlor'
    """
    words = s.split(" ")
    return " ".join(map(lambda x: "".join(sorted(x, key=lambda ch: ord(ch))), words))

def anti_shuffle(s):
    _input = (s,)
    assert precondition(_input)
    _output = _impl(s)
    assert postcondition(_input, _output)
    return _output
