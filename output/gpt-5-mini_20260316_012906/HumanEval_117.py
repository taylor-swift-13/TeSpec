
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    s, n = input
    if not isinstance(s, str):
        return False
    # n should be a non-negative integer (exclude booleans)
    if not isinstance(n, int) or isinstance(n, bool) or n < 0:
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    s, n = input
    # output must be a list of strings
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, str) for x in output):
        return False
    vowels = set("aeiou")
    def consonant_count(word):
        cnt = 0
        for ch in word:
            if ch.isalpha() and ch.lower() not in vowels:
                cnt += 1
        return cnt
    expected = [w for w in s.split() if consonant_count(w) == n]
    return output == expected

def _impl(s, n):
    """Given a string s and a natural number n, you have been tasked to implement 
    a function that returns a list of all words from string s that contain exactly 
    n consonants, in order these words appear in the string s.
    If the string s is empty then the function should return an empty list.
    Note: you may assume the input string contains only letters and spaces.
    Examples:
    select_words("Mary had a little lamb", 4) ==> ["little"]
    select_words("Mary had a little lamb", 3) ==> ["Mary", "lamb"]
    select_words("simple white space", 2) ==> []
    select_words("Hello world", 4) ==> ["world"]
    select_words("Uncle sam", 3) ==> ["Uncle"]"""
    ans = []
    for word in s.split(" "):
        if word != "":
            c_cnt = len(list(filter(lambda ch: ch not in "aeiouAEIOU", word)))
            if c_cnt == n: ans.append(word)
    return ans

def select_words(s, n):
    _input = (s, n)
    assert precondition(_input)
    _output = _impl(s, n)
    assert postcondition(_input, _output)
    return _output
