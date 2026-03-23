def _orig_right_angle_triangle_spec(a, b, c, output):
    is_right = a * a + b * b == c * c or a * a + c * c == b * b or b * b + c * c == a * a
    return bool(output) == is_right

def right_angle_triangle_spec(a, b, c, output):
    return bool(_orig_right_angle_triangle_spec(a, b, c, output))
