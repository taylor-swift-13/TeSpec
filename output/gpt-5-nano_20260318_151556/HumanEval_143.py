
def precondition(input) -> bool:
    # input should be a tuple of positional arguments; here only one argument: sentence
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    sentence = input[0]
    if not isinstance(sentence, str):
        return False
    if not (1 <= len(sentence) <= 100):
        return False
    return True

def postcondition(input, output) -> bool:
    # Check input shape
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(output, str):
        return False
    sentence = input[0]
    if not isinstance(sentence, str):
        return False

    words = sentence.split()

    def is_prime(n: int) -> bool:
        if n <= 1:
            return False
        if n <= 3:
            return True
        if n % 2 == 0:
            return False
        i = 3
        while i * i <= n:
            if n % i == 0:
                return False
            i += 2
        return True

    expected = " ".join([w for w in words if is_prime(len(w))])
    return output == expected

def _impl(sentence):
    """
    You are given a string representing a sentence,
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
        * sentence contains only letters
    """
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    return " ".join(list(filter(lambda word: is_prime(len(word)), sentence.split(" "))))

def words_in_sentence(sentence):
    _input = (sentence,)
    assert precondition(_input)
    _output = _impl(sentence)
    assert postcondition(_input, _output)
    return _output
