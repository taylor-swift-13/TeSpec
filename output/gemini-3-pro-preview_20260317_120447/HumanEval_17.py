from typing import List

def precondition(input_args: tuple) -> bool:
    music_string = input_args[0]
    if not isinstance(music_string, str):
        return False
    return True

def postcondition(input_args: tuple, output: list) -> bool:
    music_string = input_args[0]
    if not isinstance(output, list):
        return False
    
    mapping = {'o': 4, 'o|': 2, '.|': 1}
    tokens = [t for t in music_string.split(' ') if t]
    
    if len(tokens) != len(output):
        return False
    
    for t, val in zip(tokens, output):
        if t not in mapping:
            return False
        if mapping[t] != val:
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
