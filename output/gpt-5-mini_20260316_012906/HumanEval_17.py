from typing import List

def precondition(input):
    # input must be a 1-tuple whose first element is a string
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    music_string = input[0]
    return isinstance(music_string, str)

def postcondition(input, output):
    # Postcondition only meaningful when precondition holds
    if not precondition(input):
        return True
    music_string = input[0]

    # Output must be a list of ints, each either 1, 2, or 4
    if not isinstance(output, list):
        return False
    for x in output:
        if not isinstance(x, int):
            return False
        if x not in (1, 2, 4):
            return False

    # Conservative parser:
    # - allows separators: whitespace, comma, semicolon
    # - recognizes tokens: 'o' (4), 'o|' (2), '.|' (1)
    s = music_string
    i = 0
    tokens = []
    parse_failed = False
    L = len(s)
    while i < L:
        ch = s[i]
        # skip separators
        if ch.isspace() or ch in {',', ';'}:
            i += 1
            continue
        if ch == 'o':
            # check for immediate '|' following
            if i + 1 < L and s[i + 1] == '|':
                tokens.append('o|')
                i += 2
            else:
                tokens.append('o')
                i += 1
            continue
        if ch == '.':
            # must be followed immediately by '|'
            if i + 1 < L and s[i + 1] == '|':
                tokens.append('.|')
                i += 2
                continue
            else:
                parse_failed = True
                break
        # any other non-separator character makes this conservative parser give up
        parse_failed = True
        break

    if parse_failed:
        # If we couldn't confidently parse the input, only enforce the basic type/value constraints above
        return True

    # Map tokens to beats
    mapping = {'o': 4, 'o|': 2, '.|': 1}
    expected = [mapping[t] for t in tokens]

    return expected == output

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
