solar_system = [
    "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"
]

def get_planet_index(p_name: str):
    try:
        return solar_system.index(p_name)
    except ValueError:
        return None

def _orig_problem_148_pre(planet1: str, planet2: str) -> bool:
    return True

def _orig_problem_148_spec(planet1: str, planet2: str, output: list) -> bool:
    idx1 = get_planet_index(planet1)
    idx2 = get_planet_index(planet2)
    if idx1 is not None and idx2 is not None:
        min_idx = min(idx1, idx2)
        max_idx = max(idx1, idx2)
        expected = solar_system[min_idx + 1:max_idx]
        return list(output) == expected
    else:
        return list(output) == []

def problem_148_pre(planet1, planet2):
    return bool(_orig_problem_148_pre(planet1, planet2))

def problem_148_spec(planet1, planet2, output):
    return bool(_orig_problem_148_spec(planet1, planet2, output))
