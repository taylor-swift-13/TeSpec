def right_angle_triangle_spec(a, b, c, res):
    is_right_angle = (a ** 2 + b ** 2 == c ** 2) or \
                     (a ** 2 + c ** 2 == b ** 2) or \
                     (b ** 2 + c ** 2 == a ** 2)
    return res == is_right_angle
