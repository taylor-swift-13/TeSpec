def is_prime(n):
    if n < 2:
        return False
    for d in range(2, int(n**0.5) + 1):
        if n % d == 0:
            return False
    return True

def split_by_space(s):
    return s.split(' ')

def join_by_space(words):
    return ' '.join(words)

def word_length(w):
    return len(w)

def words_in_sentence_spec(sentence, result):
    words = split_by_space(sentence)
    filtered_words = [w for w in words if is_prime(word_length(w))]
    expected_result = join_by_space(filtered_words)
    return result == expected_result

def _impl(sentence):
    def is_prime(a):
        return not (a < 2 or any(a % x == 0 for x in range(2, int(a ** 0.5) + 1)))
    return " ".join(list(filter(lambda word: is_prime(len(word)), sentence.split(" "))))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(words_in_sentence_spec(*input, output))

def words_in_sentence(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
