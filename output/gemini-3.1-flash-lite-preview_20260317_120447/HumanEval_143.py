
def precondition(input):
    sentence = input[0]
    return isinstance(sentence, str) and 1 <= len(sentence) <= 100 and sentence.replace(" ", "").isalpha()

def postcondition(input, output):
    def is_prime(n):
        if n < 2:
            return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                return False
        return True

    sentence = input[0]
    words = sentence.split()
    expected_words = [w for w in words if is_prime(len(w))]
    expected_output = " ".join(expected_words)
    
    return output == expected_output

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
