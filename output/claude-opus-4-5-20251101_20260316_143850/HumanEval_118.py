
def precondition(input):
    if len(input) != 1:
        return False
    word = input[0]
    if not isinstance(word, str):
        return False
    if not word.isalpha():
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, str):
        return False
    word = input[0]
    vowels = "aeiouAEIOU"
    consonants = "bcdfghjklmnpqrstvwxyzBCDFGHJKLMNPQRSTVWXYZ"
    
    if output == "":
        # Verify no valid vowel exists between two consonants (excluding first and last positions)
        for i in range(len(word) - 2, 0, -1):
            if word[i] in vowels:
                if i > 0 and i < len(word) - 1:
                    if word[i - 1] in consonants and word[i + 1] in consonants:
                        return False
        return True
    else:
        # Output should be a single vowel character
        if len(output) != 1:
            return False
        if output not in vowels:
            return False
        # Output should exist in the word
        if output not in word:
            return False
        # Find the rightmost vowel between two consonants (not at beginning or end)
        found_index = -1
        for i in range(len(word) - 2, 0, -1):
            if word[i] in vowels:
                if word[i - 1] in consonants and word[i + 1] in consonants:
                    found_index = i
                    break
        if found_index == -1:
            return False
        if word[found_index] != output:
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
