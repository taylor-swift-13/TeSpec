from typing import List

def precondition(input):
    # input should be a tuple with a single string argument
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False
    allowed_chars = set(['o', '.', '|'])
    for ch in s:
        if not ch.isspace() and ch not in allowed_chars:
            return False
    return True

def postcondition(input, output):
    # verify output matches durations parsed from input string
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    if not isinstance(input[0], str):
        return False
    if not isinstance(output, list):
        return False

    s = input[0]
    durations = []
    i = 0
    while i < len(s):
        ch = s[i]
        if ch.isspace():
            i += 1
            continue
        two = s[i:i+2]
        if two in ('o|', '.|'):
            tok = two
            i += 2
        elif ch == 'o':
            tok = 'o'
            i += 1
        else:
            return False  # invalid token encountered

        if tok == 'o':
            durations.append(4)
        elif tok == 'o|':
            durations.append(2)
        elif tok == '.|':
            durations.append(1)
        else:
            return False

    if len(output) != len(durations):
        return False
    for a, b in zip(output, durations):
        if not isinstance(a, int) or a != b:
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
