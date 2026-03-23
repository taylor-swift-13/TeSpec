def list_of_string(s: str) -> list:
    return list(s)

def ascii_le(c1: str, c2: str) -> bool:
    return ord(c1) <= ord(c2)

def is_sorted_string(s: str) -> bool:
    return list(s) == sorted(list(s))

def is_permutation_string(s1: str, s2: str) -> bool:
    return sorted(list(s1)) == sorted(list(s2))

def word_has_no_space(s: str) -> bool:
    return " " not in s

def join_space(l: list) -> str:
    return " ".join(l)

def word_transform(input_word: str, output_word: str) -> bool:
    return is_permutation_string(input_word, output_word) and is_sorted_string(output_word)

def anti_shuffle_spec(s: str, result: str) -> bool:
    words = s.split(" ")
    ordered_words = result.split(" ")
    
    if len(words) != len(ordered_words):
        return False
        
    for w1, w2 in zip(words, ordered_words):
        if not word_transform(w1, w2):
            return False
            
    return True

def _impl(s):
    words = s.split(" ")
    return " ".join(map(lambda x: "".join(sorted(x, key=lambda ch: ord(ch))), words))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(anti_shuffle_spec(*input, output))

def anti_shuffle(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
