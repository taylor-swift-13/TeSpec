def _orig_car_race_collision_spec(n, collisions):
    """
    Returns True if collisions is equal to n squared, False otherwise.
    """
    return collisions == n * n

def car_race_collision_spec(n, output):
    return bool(_orig_car_race_collision_spec(n, output))
