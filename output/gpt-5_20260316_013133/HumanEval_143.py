
def precondition(input) -> bool:
    if not (isinstance(input, tuple) and len(input) == 1):
        return False
    sentence = input[0]
    if not isinstance(sentence, str):
        return False
    n = len(sentence)
    if n < 1 or n > 100:
        return False
    # Allow letters and spaces only, and ensure there is at least one letter
    has_letter = False
    for ch in sentence:
        if ch == ' ':
            continue
        if ch.isalpha():
            has_letter = True
        else:
            return False
    if not has_letter:
        return False
    return True

def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    sentence = input[0]

    def is_prime(k: int) -> bool:
        if k < 2:
            return False
        if k == 2:
            return True
        if k % 2 == 0:
            return False
        d = 3
        while d * d <= k:
            if k % d == 0:
                return False
            d += 2
        return True

    # Split on spaces, ignore empty segments to be tolerant of multiple spaces
    in_words = [w for w in sentence.split(' ') if w != '']
    expected = [w for w in in_words if is_prime(len(w))]
    out_words = [w for w in output.split(' ') if w != '']
    return out_words == expected

def _impl(sentence):
    """You are given a string representing a sentence,
    the sentence contains some words separated by a space,
    and you have to return a string that contains the words from the original sentence,
    whose lengths are prime numbers,
    the order of the words in the new string should be the same as the original one.

    Example 1:
        Input: sentence = "This is a test"
        Output: "is"

    Example 2:
        Input: sentence = "lets go for swimming"
        Output: "go for"

    Constraints:
        * 1 <= len(sentence) <= 100
        * sentence contains only letters"""
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    return " ".join(list(filter(lambda word: is_prime(len(word)), sentence.split(" "))))

def words_in_sentence(sentence):
    _input = (sentence,)
    assert precondition(_input)
    _output = _impl(sentence)
    assert postcondition(_input, _output)
    return _output
