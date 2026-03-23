planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

def bf_spec(planet1, planet2, result):
    valid_p1 = planet1 in planets
    valid_p2 = planet2 in planets
    
    if not valid_p1 or not valid_p2:
        return result == []
    
    i1 = planets.index(planet1)
    i2 = planets.index(planet2)
    
    start = min(i1, i2)
    stop = max(i1, i2)
    
    expected = planets[start + 1 : stop]
    return result == expected

def _impl(planet1, planet2):
    planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    if planet1 not in planets or planet2 not in planets: return tuple()
    i1, i2 = planets.index(planet1), planets.index(planet2)
    if i1 > i2: i1, i2 = i2, i1
    return tuple(planets[i1 + 1 : i2])

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(bf_spec(*input, output))

def bf(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
