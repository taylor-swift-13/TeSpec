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

def parse_music_spec(music_string, result):
    # (music_string = "" -> result = [])
    if music_string == "":
        return result == []
    
    # (music_string <> "" -> ...)
    notes = split_by_space(music_string)
    
    # length result = length notes
    if len(result) != len(notes):
        return False
        
    # forall i note beat, ...
    for i in range(len(notes)):
        note = notes[i]
        beat = result[i]
        
        # ((note = "o" /\ beat = 4) \/ (note = "o|" /\ beat = 2) \/ (note = ".|" /\ beat = 1))
        condition = (
            (note == "o" and beat == 4) or
            (note == "o|" and beat == 2) or
            (note == ".|" and beat == 1)
        )
        
        if not condition:
            return False
            
    return True
