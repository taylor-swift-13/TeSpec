from typing import List

def precondition(input):
    args = input
    if not isinstance(args, tuple) or len(args) != 1:
        return False
    s = args[0]
    if not isinstance(s, str):
        return False

    i = 0
    n = len(s)
    while i < n:
        ch = s[i]
        if ch.isspace():
            i += 1
            continue
        if ch == 'o':
            if i + 1 < n and s[i + 1] == '|':
                i += 2
            else:
                i += 1
        elif ch == '.':
            if i + 1 < n and s[i + 1] == '|':
                i += 2
            else:
                return False
        elif ch == '|':
            return False
        else:
            return False
    return True

def postcondition(input, output):
    args = input
    if not isinstance(args, tuple) or len(args) != 1:
        return False
    s = args[0]
    if not isinstance(s, str):
        return False
    if not isinstance(output, list):
        return False

    durations = []
    i = 0
    n = len(s)
    while i < n:
        ch = s[i]
        if ch.isspace():
            i += 1
            continue
        if ch == 'o':
            if i + 1 < n and s[i + 1] == '|':
                durations.append(2)
                i += 2
            else:
                durations.append(4)
                i += 1
        elif ch == '.':
            if i + 1 < n and s[i + 1] == '|':
                durations.append(1)
                i += 2
            else:
                return False
        elif ch == '|':
            return False
        else:
            return False

    return durations == output

def _impl(music_string: str) -> List[int]:
    """
    Input to this function is a string representing musical notes in a special ASCII format.
    Your task is to parse this string and return list of integers corresponding to how many beats does each
    not last.

    Here is a legend:
    'o' - whole note, lasts four beats
    'o|' - half note, lasts two beats
    '.|' - quater note, lasts one beat

    [4, 2, 1, 2, 2, 1, 1, 1, 1, 4, 4]
    """
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
