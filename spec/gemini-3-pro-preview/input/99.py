# Old incorrect translation:
# def _orig_closest_integer_spec(val, output):
#     dist = abs(val - output)
#     return dist < 0.5 or (dist == 0.5 and abs(output) > abs(val))
def _orig_closest_integer_spec(val, output):
    dist = abs(val - output)
    return dist < 0.5 or (dist == 0.5 and abs(output) > abs(val))

def closest_integer_spec(value, output):
    try:
        val = float(value)
    except (TypeError, ValueError):
        return False
    return bool(_orig_closest_integer_spec(val, output))
