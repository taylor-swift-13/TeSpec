def _orig_concatenate_spec(strings, output):
    return output == ''.join(strings)

def concatenate_spec(strings, output):
    return bool(_orig_concatenate_spec(strings, output))
