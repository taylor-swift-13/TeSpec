
def precondition(input):
    word, = input
    if not isinstance(word, str):
        return False
    if not word:
        return False
    for ch in word:
        if not ('A' <= ch <= 'Z' or 'a' <= ch <= 'z'):
            return False
    return True

def postcondition(input, output):
    word, = input
    if not isinstance(output, str):
        return False
    if output == "":
        return True
    if len(output) != 1:
        return False
    if output not in "AEIOUaeiou":
        return False
    if len(word) < 3:
        return False
    output_idx = word.rfind(output)
    if output_idx == -1:
        return False
    if output_idx == 0 or output_idx == len(word) - 1:
        return False
    return True

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
