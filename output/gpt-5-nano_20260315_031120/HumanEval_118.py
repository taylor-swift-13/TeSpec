
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    word = input[0]
    if not isinstance(word, str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    word = input[0]
    if not isinstance(word, str):
        return False
    if not isinstance(output, str):
        return False

    vowels = set("aeiouAEIOU")
    s = word
    rightmost = -1
    for i, ch in enumerate(s):
        if ch in vowels:
            if i > 0 and i < len(s) - 1:
                if (s[i - 1] not in vowels) and (s[i + 1] not in vowels):
                    rightmost = i
    expected = s[rightmost] if rightmost != -1 else ""
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
