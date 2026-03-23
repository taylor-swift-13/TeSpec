def _orig_right_angle_triangle_spec(a, b, c, output):
    is_right_angle = a ** 2 + b ** 2 == c ** 2 or a ** 2 + c ** 2 == b ** 2 or b ** 2 + c ** 2 == a ** 2
    return output == is_right_angle

def right_angle_triangle_spec(a, b, c, output):
    return bool(_orig_right_angle_triangle_spec(a, b, c, output))
