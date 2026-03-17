
def precondition(inp) -> bool:
    if len(inp) != 1:
        return False
    word = inp[0]
    if not isinstance(word, str):
        return False
    return True

def postcondition(inp, out) -> bool:
    word = inp[0]
    if not isinstance(out, str):
        return False
    if len(out) not in (0, 1):
        return False
    if len(out) == 1:
        if out not in "aeiouAEIOU":
            return False
        if out not in word:
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
