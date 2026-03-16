
def precondition(input):
    s, n = input
    if not isinstance(s, str):
        return False
    if not isinstance(n, int):
        return False
    if n < 0:
        return False
    for char in s:
        if not (char.isalpha() or char == ' '):
            return False
    return True

def postcondition(input, output):
    s, n = input
    if not isinstance(output, list):
        return False
    if not all(isinstance(word, str) for word in output):
        return False
    words = s.split()
    output_index = 0
    for word in words:
        consonants = sum(1 for char in word if char.lower() not in 'aeiou')
        if consonants == n:
            if output_index >= len(output) or output[output_index] != word:
                return False
            output_index += 1
    return output_index == len(output)

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
