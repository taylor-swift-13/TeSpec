
def precondition(args):
    if len(args) != 1:
        return False
    word = args[0]
    if not isinstance(word, str):
        return False
    if not word.isalpha():
        return False
    return True


def postcondition(args, output):
    word = args[0]
    if not isinstance(output, str):
        return False
    vowels = set('aeiouAEIOU')
    
    if output == "":
        # Verify no vowel between two consonants exists from the right
        # Check that there is indeed no such vowel
        for i in range(len(word) - 2, 0, -1):
            c = word[i]
            if c in vowels:
                left = word[i - 1]
                right = word[i + 1]
                if left not in vowels and right not in vowels:
                    return False
        return True
    else:
        # output should be a single character vowel
        if len(output) != 1:
            return False
        if output not in vowels:
            return False
        # Find the rightmost vowel between two consonants
        for i in range(len(word) - 2, 0, -1):
            c = word[i]
            if c in vowels:
                left = word[i - 1]
                right = word[i + 1]
                if left not in vowels and right not in vowels:
                    return output == c
        return False

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
