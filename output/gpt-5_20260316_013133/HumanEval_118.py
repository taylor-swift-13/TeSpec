
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    word = input[0]
    if not isinstance(word, str):
        return False
    for ch in word:
        if not (ch.isascii() and ch.isalpha()):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    if not isinstance(output, str):
        return False
    word = input[0]
    vowels = set("AEIOUaeiou")
    def is_consonant(c):
        return c.isascii() and c.isalpha() and c not in vowels
    expected = ""
    n = len(word)
    for i in range(n - 2, 0, -1):
        if word[i] in vowels and is_consonant(word[i - 1]) and is_consonant(word[i + 1]):
            expected = word[i]
            break
    return output == expected

def _impl(word):
    """You are given a word. Your task is to find the closest vowel that stands between 
    two consonants from the right side of the word (case sensitive).

    Vowels in the beginning and ending doesn't count. Return empty string if you didn't
    find any vowel met the above condition. 

    You may assume that the given string contains English letter only.

    Example:
    get_closest_vowel("yogurt") ==> "u"
    get_closest_vowel("FULL") ==> "U"
    get_closest_vowel("quick") ==> ""
    get_closest_vowel("ab") ==> ""
    """
    def is_vowel(ch: str) -> bool:
        return ch in "aeiouAEIOU"
    for i in range(len(word) - 2, 0, -1):
        if is_vowel(word[i]) and not is_vowel(word[i-1]) and not is_vowel(word[i+1]):
            return word[i]
    return ""

def get_closest_vowel(word):
    _input = (word,)
    assert precondition(_input)
    _output = _impl(word)
    assert postcondition(_input, _output)
    return _output
