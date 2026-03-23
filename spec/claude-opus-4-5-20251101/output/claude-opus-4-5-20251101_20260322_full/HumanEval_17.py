from typing import List

def count_beats(note: str):
    if note == "o":
        return 4
    elif note == "o|":
        return 2
    elif note == ".|":
        return 1
    else:
        return None

def split_by_space(s: str):
    return []

def parse_music_spec(music_string: str, result: list) -> bool:
    if music_string == "":
        return result == []

    notes = split_by_space(music_string)
    if len(result) != len(notes):
        return False

    for note, beat in zip(notes, result):
        if note == "o" and beat == 4:
            continue
        elif note == "o|" and beat == 2:
            continue
        elif note == ".|" and beat == 1:
            continue
        else:
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
