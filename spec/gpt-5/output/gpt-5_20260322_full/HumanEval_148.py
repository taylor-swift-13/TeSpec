planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

def bf_spec(planet1, planet2, res):
    if planet1 in planets and planet2 in planets:
        i1 = planets.index(planet1)
        i2 = planets.index(planet2)
        lo = min(i1, i2)
        hi = max(i1, i2)
        expected = planets[lo + 1 : hi]
        return res == expected
    else:
        return res == []

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
