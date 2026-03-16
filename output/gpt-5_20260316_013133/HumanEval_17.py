from typing import List

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    music_string = input[0]
    return isinstance(music_string, str)


def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1 or not isinstance(input[0], str):
        return False
    s = input[0]

    if not isinstance(output, list):
        return False
    if not all(isinstance(x, int) for x in output):
        return False
    if not all(x in (1, 2, 4) for x in output):
        return False

    c1 = sum(1 for x in output if x == 1)
    c2 = sum(1 for x in output if x == 2)
    c4 = sum(1 for x in output if x == 4)

    so = s.count('o')
    sd = s.count('.')
    sp = s.count('|')

    # Necessary character availability for the produced notes
    if so < (c4 + c2):
        return False
    if sd < c1:
        return False
    if sp < (c2 + c1):
        return False

    # Each note uses either an 'o' or a '.' character
    if (c1 + c2 + c4) > (so + sd):
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
