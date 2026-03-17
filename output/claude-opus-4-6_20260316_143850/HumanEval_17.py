from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    music_string = input[0]
    if not isinstance(music_string, str):
        return False
    # Validate that the string only contains valid note tokens separated by spaces
    if music_string.strip() == '':
        return True
    tokens = music_string.split()
    for token in tokens:
        if token not in ('o', 'o|', '.|'):
            return False
    return True


def postcondition(input, output):
    music_string = input[0]
    if not isinstance(output, list):
        return False
    # All elements should be integers from {1, 2, 4}
    for val in output:
        if not isinstance(val, int):
            return False
        if val not in (1, 2, 4):
            return False
    # The number of notes in output should match the number of tokens
    if music_string.strip() == '':
        return output == []
    tokens = music_string.split()
    if len(output) != len(tokens):
        return False
    # Verify each token maps to the correct beat count
    mapping = {'o': 4, 'o|': 2, '.|': 1}
    for token, val in zip(tokens, output):
        if token in mapping and mapping[token] != val:
            return False
    # Total beats should match sum of expected
    expected_sum = sum(mapping[t] for t in tokens)
    if sum(output) != expected_sum:
        return False
    return True

def _impl(music_string: str) -> List[int]:
    """Input to this function is a string representing musical notes in a special ASCII format.
    Your task is to parse this string and return list of integers corresponding to how many beats does each
    not last.

    Here is a legend:
    'o' - whole note, lasts four beats
    'o|' - half note, lasts two beats
    '.|' - quater note, lasts one beat

    [4, 2, 1, 2, 2, 1, 1, 1, 1, 4, 4]"""
    def count_beats(note: str) -> int:
        if note == "o": return 4
        elif note == "o|": return 2
        elif note == ".|": return 1

    if music_string == "": return []
    return list(map(count_beats, music_string.split(" ")))

def parse_music(music_string: str) -> List[int]:
    _input = (music_string,)
    assert precondition(_input)
    _output = _impl(music_string)
    assert postcondition(_input, _output)
    return _output
