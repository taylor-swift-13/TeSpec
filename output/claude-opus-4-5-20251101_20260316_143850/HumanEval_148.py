
def precondition(input):
    if len(input) != 2:
        return False
    planet1, planet2 = input
    if not isinstance(planet1, str):
        return False
    if not isinstance(planet2, str):
        return False
    return True


def postcondition(input, output):
    if not isinstance(output, tuple):
        return False
    
    planets = ("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
    planet1, planet2 = input
    
    # If either planet is invalid, should return empty tuple
    if planet1 not in planets or planet2 not in planets:
        return output == ()
    
    # All elements in output should be valid planet names
    for p in output:
        if not isinstance(p, str):
            return False
        if p not in planets:
            return False
    
    # Output should not contain the input planets
    if planet1 in output or planet2 in output:
        return False
    
    # Get indices
    idx1 = planets.index(planet1)
    idx2 = planets.index(planet2)
    
    # If same planet, should return empty tuple
    if idx1 == idx2:
        return output == ()
    
    # Determine the range between the two planets
    low_idx = min(idx1, idx2)
    high_idx = max(idx1, idx2)
    
    # Expected planets between them (exclusive)
    expected = tuple(planets[i] for i in range(low_idx + 1, high_idx))
    
    return output == expected

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
