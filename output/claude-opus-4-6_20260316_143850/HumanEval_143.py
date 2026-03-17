
def precondition(input):
    (sentence,) = input
    if not isinstance(sentence, str):
        return False
    if not (1 <= len(sentence) <= 100):
        return False
    # sentence contains only letters and spaces
    if not all(c.isalpha() or c == ' ' for c in sentence):
        return False
    # Must have at least some content (words separated by spaces)
    # No leading/trailing spaces or double spaces based on examples
    words = sentence.split(' ')
    if any(w == '' for w in words):
        # would imply leading/trailing/double spaces
        return False
    return True


def postcondition(input, output):
    (sentence,) = input
    if not isinstance(output, str):
        return False

    def is_prime(n):
        if n < 2:
            return False
        if n == 2:
            return True
        if n % 2 == 0:
            return False
        for i in range(3, int(n**0.5) + 1, 2):
            if n % i == 0:
                return False
        return True

    words = sentence.split(' ')
    prime_words = [w for w in words if is_prime(len(w))]
    expected = ' '.join(prime_words)

    if output != expected:
        return False

    return True

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
