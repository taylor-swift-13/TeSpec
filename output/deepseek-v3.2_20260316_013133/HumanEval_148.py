
def precondition(input):
    planet1, planet2 = input
    planets = {"Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"}
    return isinstance(planet1, str) and isinstance(planet2, str) and planet1 in planets and planet2 in planets

def postcondition(input, output):
    planet1, planet2 = input
    planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
    if not (isinstance(planet1, str) and isinstance(planet2, str) and planet1 in planets and planet2 in planets):
        return output == ()
    idx1 = planets.index(planet1)
    idx2 = planets.index(planet2)
    start = min(idx1, idx2) + 1
    end = max(idx1, idx2)
    expected = tuple(planets[start:end])
    return isinstance(output, tuple) and all(isinstance(p, str) for p in output) and output == expected

def _impl(planet1, planet2):
    """There are eight planets in our solar system: the closerst to the Sun 
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
    bf("Mercury", "Uranus") ==> ("Venus", "Earth", "Mars", "Jupiter", "Saturn")"""
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
