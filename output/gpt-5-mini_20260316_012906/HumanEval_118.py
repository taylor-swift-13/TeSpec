
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    # Ensure all characters are English letters (A-Z or a-z). Allow empty string.
    for ch in s:
        if not ('A' <= ch <= 'Z' or 'a' <= ch <= 'z'):
            return False
    return True

def postcondition(input, output):
    # If precondition does not hold, do not constrain output here.
    if not precondition(input):
        return True
    s = input[0]
    if not isinstance(output, str):
        return False
    vowels = set('aeiouAEIOU')
    n = len(s)
    valid_indices = []
    for i in range(1, n-1):
        if s[i] in vowels and s[i-1] not in vowels and s[i+1] not in vowels:
            valid_indices.append(i)
    if not valid_indices:
        return output == ""
    # There is at least one valid vowel between consonants; must return the rightmost one (preserve case).
    expected = s[max(valid_indices)]
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
    get_closest_vowel("ab") ==> """""
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
