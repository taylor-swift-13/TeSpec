def _orig_car_race_collision_spec(n: int, output: int) -> bool:
    return output == n * n

def car_race_collision_spec(n, output):
    return bool(_orig_car_race_collision_spec(n, output))
