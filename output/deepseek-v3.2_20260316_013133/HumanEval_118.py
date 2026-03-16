
def precondition(args):
    word = args[0]
    if not isinstance(word, str):
        return False
    if not word:
        return False
    for ch in word:
        if not ('A' <= ch <= 'Z' or 'a' <= ch <= 'z'):
            return False
    return True

def postcondition(args, result):
    word = args[0]
    if not isinstance(result, str):
        return False
    if result == "":
        return True
    if len(result) != 1:
        return False
    if result not in "AEIOUaeiou":
        return False
    idx = word.rfind(result)
    if idx == -1:
        return False
    if idx == 0 or idx == len(word) - 1:
        return False
    left_ok = idx > 0 and word[idx-1] not in "AEIOUaeiou"
    right_ok = idx < len(word) - 1 and word[idx+1] not in "AEIOUaeiou"
    if not (left_ok and right_ok):
        return False
    for i in range(idx + 1, len(word) - 1):
        ch = word[i]
        if ch in "AEIOUaeiou":
            left_ok2 = i > 0 and word[i-1] not in "AEIOUaeiou"
            right_ok2 = i < len(word) - 1 and word[i+1] not in "AEIOUaeiou"
            if left_ok2 and right_ok2:
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
