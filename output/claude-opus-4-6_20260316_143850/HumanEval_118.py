
def precondition(input):
    (word,) = input
    if not isinstance(word, str):
        return False
    if len(word) == 0:
        return False
    # Only English letters
    if not all(c.isalpha() and c.isascii() for c in word):
        return False
    return True


def postcondition(input, output):
    (word,) = input
    if not isinstance(output, str):
        return False
    
    vowels = "aeiouAEIOU"
    consonants = set("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ") - set(vowels)
    
    if output == "":
        # Verify no vowel between two consonants exists (excluding first and last positions)
        for i in range(len(word) - 2, 0, -1):
            if word[i] in vowels and word[i + 1] in consonants and word[i - 1] in consonants:
                return False
        return True
    else:
        # output should be a single vowel character
        if len(output) != 1 or output not in vowels:
            return False
        
        # Find the rightmost vowel between two consonants (not at beginning or end)
        for i in range(len(word) - 2, 0, -1):
            if word[i] in vowels and word[i + 1] in consonants and word[i - 1] in consonants:
                # This should be the first one found from the right, and it should match output
                return word[i] == output
        
        # If we didn't find any such vowel, output should have been ""
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
