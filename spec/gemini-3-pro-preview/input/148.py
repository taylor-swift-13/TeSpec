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
