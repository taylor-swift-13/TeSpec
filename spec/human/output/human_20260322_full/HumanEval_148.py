solar_system = [
    "Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"
]

def get_planet_index(p_name: str):
    try:
        return solar_system.index(p_name)
    except ValueError:
        return None

def problem_148_pre(planet1: str, planet2: str) -> bool:
    return True

def problem_148_spec(planet1: str, planet2: str, result: list) -> bool:
    idx1 = get_planet_index(planet1)
    idx2 = get_planet_index(planet2)
    
    if idx1 is not None and idx2 is not None:
        min_idx = min(idx1, idx2)
        max_idx = max(idx1, idx2)
        
        expected = solar_system[min_idx + 1 : max_idx]
        return list(result) == expected
    else:
        return list(result) == []

def _impl(planet1, planet2):
    planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    if planet1 not in planets or planet2 not in planets: return tuple()
    i1, i2 = planets.index(planet1), planets.index(planet2)
    if i1 > i2: i1, i2 = i2, i1
    return tuple(planets[i1 + 1 : i2])

def precondition(input) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_148_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_148_spec(*input, output))

def bf(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
