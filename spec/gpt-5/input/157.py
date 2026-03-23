def right_angle_triangle_spec(a, b, c, res):
    expected = (a * a + b * b == c * c) or \
               (a * a + c * c == b * b) or \
               (b * b + c * c == a * a)
    return res == expected
