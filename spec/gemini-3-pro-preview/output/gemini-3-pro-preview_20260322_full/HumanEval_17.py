from typing import List

def note_to_beats(s: str):
    if s == "o":
        return 4
    elif s == "o|":
        return 2
    elif s == ".|":
        return 1
    else:
        return None

def join(sep: str, l: list) -> str:
    if not l:
        return ""
    elif len(l) == 1:
        return l[0]
    else:
        return l[0] + sep + join(sep, l[1:])

def parse_music_spec(music_string: str, result: list) -> bool:
    if music_string == "" and result == []:
        return True
    if music_string != "":
        notes = music_string.split(" ")
        if len(notes) != len(result):
            return False
        for note, beats in zip(notes, result):
            if note_to_beats(note) != beats:
                return False
        return True
    return False

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
