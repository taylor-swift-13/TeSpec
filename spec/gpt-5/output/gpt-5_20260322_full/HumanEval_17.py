from typing import List

def count_beats_spec(note: str, b: int) -> bool:
    if note == "o" and b == 4:
        return True
    if note == "o|" and b == 2:
        return True
    if note == ".|" and b == 1:
        return True
    return False

def join_spaces(tokens: list) -> str:
    return " ".join(tokens)

def parse_music_spec(music_string: str, beats: list) -> bool:
    if music_string == "":
        tokens = []
    else:
        tokens = music_string.split(" ")
        
    if len(tokens) != len(beats):
        return False
        
    for t, b in zip(tokens, beats):
        if not count_beats_spec(t, b):
            return False
            
    return True

def _impl(music_string: str) -> List[int]:
    def count_beats(note: str) -> int:
        if note == "o": return 4
        elif note == "o|": return 2
        elif note == ".|": return 1
    if music_string == "": return []
    return list(map(count_beats, music_string.split(" ")))

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(parse_music_spec(*input, output))

def parse_music(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
