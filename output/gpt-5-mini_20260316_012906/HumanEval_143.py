
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    sentence = input[0]
    if not isinstance(sentence, str):
        return False
    if not (1 <= len(sentence) <= 100):
        return False
    # sentence may contain letters and spaces only
    for ch in sentence:
        if not (ch.isalpha() or ch == ' '):
            return False
    # there must be at least one letter (i.e., at least one word)
    if not any(ch.isalpha() for ch in sentence):
        return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return False
    sentence = input[0]
    if not isinstance(output, str):
        return False
    # extract words as non-empty sequences separated by spaces
    words = [w for w in sentence.split(' ') if w != '']
    # helper to test primality
    def is_prime(n):
        if n < 2:
            return False
        if n == 2:
            return True
        if n % 2 == 0:
            return False
        i = 3
        while i * i <= n:
            if n % i == 0:
                return False
            i += 2
        return True
    selected = [w for w in words if is_prime(len(w))]
    expected = " ".join(selected)
    return output == expected

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
