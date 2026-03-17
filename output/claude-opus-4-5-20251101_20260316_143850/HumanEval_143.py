
def precondition(args):
    sentence = args[0]
    
    # Check that sentence is a string
    if not isinstance(sentence, str):
        return False
    
    # Check length constraint: 1 <= len(sentence) <= 100
    if len(sentence) < 1 or len(sentence) > 100:
        return False
    
    # Check that sentence contains only letters and spaces
    for char in sentence:
        if not (char.isalpha() or char == ' '):
            return False
    
    return True


def postcondition(args, output):
    sentence = args[0]
    
    # Check that output is a string
    if not isinstance(output, str):
        return False
    
    # Check that output contains only letters and spaces
    for char in output:
        if not (char.isalpha() or char == ' '):
            return False
    
    # Helper function to check if a number is prime
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
    
    # Get words from input and output
    input_words = sentence.split()
    output_words = output.split() if output else []
    
    # All output words should have prime length
    for word in output_words:
        if not is_prime(len(word)):
            return False
    
    # All output words should be from input (in order)
    # and should be exactly the words with prime lengths
    expected_words = [word for word in input_words if is_prime(len(word))]
    
    if output_words != expected_words:
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
