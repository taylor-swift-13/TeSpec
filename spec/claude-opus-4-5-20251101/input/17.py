def count_beats(note):
    if note == "o":
        return 4
    elif note == "o|":
        return 2
    elif note == ".|":
        return 1
    else:
        return None

def split_by_space(s):
    # Matches Coq's placeholder implementation which always returns []
    return []

def _orig_parse_music_spec(music_string, output):
    if music_string == '':
        return output == []
    notes = split_by_space(music_string)
    if len(output) != len(notes):
        return False
    for i in range(len(notes)):
        note = notes[i]
        beat = output[i]
        condition = note == 'o' and beat == 4 or (note == 'o|' and beat == 2) or (note == '.|' and beat == 1)
        if not condition:
            return False
    return True

def parse_music_spec(music_string, output):
    return bool(_orig_parse_music_spec(music_string, output))
