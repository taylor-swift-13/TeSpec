def to_letter_grade_spec(score: float, grade: str) -> bool:
    return (
        (score == 4.0 and grade == "A+") or
        (score != 4.0 and score > 3.7 and grade == "A") or
        (score <= 3.7 and score > 3.3 and grade == "A-") or
        (score <= 3.3 and score > 3.0 and grade == "B+") or
        (score <= 3.0 and score > 2.7 and grade == "B") or
        (score <= 2.7 and score > 2.3 and grade == "B-") or
        (score <= 2.3 and score > 2.0 and grade == "C+") or
        (score <= 2.0 and score > 1.7 and grade == "C") or
        (score <= 1.7 and score > 1.3 and grade == "C-") or
        (score <= 1.3 and score > 1.0 and grade == "D+") or
        (score <= 1.0 and score > 0.7 and grade == "D") or
        (score <= 0.7 and score > 0.0 and grade == "D-") or
        (score <= 0.0 and grade == "E")
    )

def numerical_letter_grade_spec(grades: list, result: list) -> bool:
    if len(grades) != len(result):
        return False
    return all(to_letter_grade_spec(s, g) for s, g in zip(grades, result))

def _impl(grades):
    def to_letter_grade(score):
      if score == 4.0:
        return "A+"
      elif score > 3.7:
        return "A"
      elif score > 3.3:
        return "A-"
      elif score > 3.0:
        return "B+"
      elif score > 2.7:
        return "B"
      elif score > 2.3:
        return "B-"
      elif score > 2.0:
        return "C+"
      elif score > 1.7:
        return "C"
      elif score > 1.3:
        return "C-"
      elif score > 1.0:
        return "D+"
      elif score > 0.7:
        return "D"
      elif score > 0.0:
        return "D-"
      else:
        return "E"
    return [to_letter_grade(x) for x in grades]

def precondition(input) -> bool:
    return True

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(numerical_letter_grade_spec(*input, output))

def numerical_letter_grade(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
