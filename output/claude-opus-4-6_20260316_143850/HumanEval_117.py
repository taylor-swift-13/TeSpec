
def precondition(input):
    try:
        s, n = input
        if not isinstance(s, str):
            return False
        if not isinstance(n, int) or isinstance(n, bool):
            return False
        if n < 0:
            return False
        # String contains only letters and spaces
        if not all(c.isalpha() or c == ' ' for c in s):
            return False
        return True
    except Exception:
        return False


def postcondition(input, output):
    try:
        s, n = input
        if not isinstance(output, list):
            return False
        if not all(isinstance(w, str) for w in output):
            return False
        
        # If s is empty, output should be empty
        if s == "" and output != []:
            return False
        
        vowels = set("aeiouAEIOU")
        
        # Each word in output should have exactly n consonants
        for word in output:
            consonant_count = sum(1 for c in word if c.isalpha() and c not in vowels)
            if consonant_count != n:
                return False
        
        # All words in output should be words from s
        words_in_s = s.split()
        
        # Check that output words appear in words_in_s with correct multiplicity
        # and in the correct order
        output_idx = 0
        for word in words_in_s:
            if output_idx < len(output) and word == output[output_idx]:
                output_idx += 1
        if output_idx != len(output):
            return False
        
        # Check completeness: every word in s with exactly n consonants should be in output
        expected = [w for w in words_in_s if sum(1 for c in w if c.isalpha() and c not in vowels) == n]
        if output != expected:
            return False
        
        return True
    except Exception:
        return False

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
