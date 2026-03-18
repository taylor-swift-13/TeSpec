
def precondition(input):
    PLANETS = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    p1, p2 = input
    if not isinstance(p1, str) or not isinstance(p2, str):
        return False
    p1 = p1.strip()
    p2 = p2.strip()
    return p1 in PLANETS and p2 in PLANETS

def postcondition(input, output):
    PLANETS = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    if not isinstance(input, tuple) or len(input) != 2:
        return output == ()
    p1, p2 = input
    if not isinstance(p1, str) or not isinstance(p2, str):
        return output == ()
    p1 = p1.strip()
    p2 = p2.strip()
    if p1 not in PLANETS or p2 not in PLANETS:
        return output == ()
    idx = {name: i for i, name in enumerate(PLANETS)}
    i1 = idx[p1]
    i2 = idx[p2]
    start = min(i1, i2) + 1
    end = max(i1, i2)
    expected = tuple(PLANETS[start:end])
    if not isinstance(output, tuple):
        return False
    return output == expected

def _impl(planet1, planet2):
    """
    There are eight planets in our solar system: the closerst to the Sun 
    is Mercury, the next one is Venus, then Earth, Mars, Jupiter, Saturn, 
    Uranus, Neptune.
    Write a function that takes two planet names as strings planet1 and planet2. 
    The function should return a tuple containing all planets whose orbits are 
    located between the orbit of planet1 and the orbit of planet2, sorted by 
    the proximity to the sun. 
    The function should return an empty tuple if planet1 or planet2
    are not correct planet names. 
    Examples
    bf("Jupiter", "Neptune") ==> ("Saturn", "Uranus")
    bf("Earth", "Mercury") ==> ("Venus")
    bf("Mercury", "Uranus") ==> ("Venus", "Earth", "Mars", "Jupiter", "Saturn")
    """
    planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    if planet1 not in planets or planet2 not in planets: return tuple()
    i1, i2 = planets.index(planet1), planets.index(planet2)
    if i1 > i2: i1, i2 = i2, i1
    return tuple(planets[i1 + 1 : i2])

def bf(planet1, planet2):
    _input = (planet1, planet2)
    assert precondition(_input)
    _output = _impl(planet1, planet2)
    assert postcondition(_input, _output)
    return _output
