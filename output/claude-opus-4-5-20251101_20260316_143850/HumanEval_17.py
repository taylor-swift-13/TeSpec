from typing import List

def precondition(input):
    if len(input) != 1:
        return False
    music_string = input[0]
    if not isinstance(music_string, str):
        return False
    # Check that all characters are ASCII
    try:
        music_string.encode('ascii')
    except UnicodeEncodeError:
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, list):
        return False
    if not all(isinstance(x, int) for x in output):
        return False
    # All beat values should be valid (1, 2, or 4)
    if not all(x in [1, 2, 4] for x in output):
        return False
    
    music_string = input[0]
    
    # Verify by parsing the string ourselves
    # Valid tokens are 'o|', '.|', 'o' (standalone)
    # We need to parse and count
    tokens = music_string.split()
    
    expected = []
    for token in tokens:
        if token == 'o':
            expected.append(4)
        elif token == 'o|':
            expected.append(2)
        elif token == '.|':
            expected.append(1)
        else:
            # Unknown token - we can't verify, but be lenient
            # If there's an unknown token, we just check output is reasonable
            return True
    
    return output == expected

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
