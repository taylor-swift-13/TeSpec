from typing import List

def precondition(args):
    if len(args) != 1:
        return False
    music_string = args[0]
    if not isinstance(music_string, str):
        return False
    return True


def postcondition(args, output):
    if not isinstance(output, list):
        return False
    for item in output:
        if not isinstance(item, int):
            return False
        if item not in (1, 2, 4):
            return False
    music_string = args[0]
    tokens = music_string.split()
    if len(tokens) != len(output):
        return False
    for token, beats in zip(tokens, output):
        if token == 'o' and beats != 4:
            return False
        if token == 'o|' and beats != 2:
            return False
        if token == '.|' and beats != 1:
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
