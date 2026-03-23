def is_vowel(c: str) -> bool:
    return c in ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"]

def remove_vowels_spec(text: str, result: str) -> bool:
    expected = "".join(c for c in text if not is_vowel(c))
    return result == expected

def _impl(text):
    return "".join(list(filter(lambda ch: ch not in "aeiouAEIOU", text)))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(remove_vowels_spec(*input, output))

def remove_vowels(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
