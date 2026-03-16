from typing import List

def precondition(input):
    music_string = input[0]
    if not isinstance(music_string, str):
        return False
    if len(music_string) == 0:
        return True
    i = 0
    while i < len(music_string):
        if music_string[i] == 'o':
            if i + 1 < len(music_string) and music_string[i + 1] == '|':
                i += 2
            else:
                i += 1
        elif music_string[i] == '.':
            if i + 1 < len(music_string) and music_string[i + 1] == '|':
                i += 2
            else:
                return False
        else:
            return False
    return True

def postcondition(input, output):
    if not isinstance(output, list):
        return False
    music_string = input[0]
    if not isinstance(music_string, str):
        return False
    i = 0
    note_count = 0
    while i < len(music_string):
        if music_string[i] == 'o':
            if i + 1 < len(music_string) and music_string[i + 1] == '|':
                i += 2
            else:
                i += 1
        elif music_string[i] == '.':
            if i + 1 < len(music_string) and music_string[i + 1] == '|':
                i += 2
            else:
                return False
        else:
            return False
        note_count += 1
    if len(output) != note_count:
        return False
    for val in output:
        if not isinstance(val, int):
            return False
        if val not in {1, 2, 4}:
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
