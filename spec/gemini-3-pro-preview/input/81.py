def to_letter_grade_spec(score: float, output: str) -> bool:
    return (
        (score == 4.0 and output == "A+") or
        (score != 4.0 and score > 3.7 and output == "A") or
        (score <= 3.7 and score > 3.3 and output == "A-") or
        (score <= 3.3 and score > 3.0 and output == "B+") or
        (score <= 3.0 and score > 2.7 and output == "B") or
        (score <= 2.7 and score > 2.3 and output == "B-") or
        (score <= 2.3 and score > 2.0 and output == "C+") or
        (score <= 2.0 and score > 1.7 and output == "C") or
        (score <= 1.7 and score > 1.3 and output == "C-") or
        (score <= 1.3 and score > 1.0 and output == "D+") or
        (score <= 1.0 and score > 0.7 and output == "D") or
        (score <= 0.7 and score > 0.0 and output == "D-") or
        (score <= 0.0 and output == "E")
    )

def _orig_numerical_letter_grade_spec(grades: list, output: list) -> bool:
    if len(grades) != len(output):
        return False
    return all((to_letter_grade_spec(s, g) for (s, g) in zip(grades, output)))

def numerical_letter_grade_spec(grades, output):
    return bool(_orig_numerical_letter_grade_spec(grades, output))
