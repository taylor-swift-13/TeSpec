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
