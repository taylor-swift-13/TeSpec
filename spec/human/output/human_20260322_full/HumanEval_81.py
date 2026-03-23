def grade_relation(gpa: float, grade: str) -> bool:
    if gpa == 4.0 and grade == "A+":
        return True
    if 3.7 < gpa < 4.0 and grade == "A":
        return True
    if 3.3 < gpa <= 3.7 and grade == "A-":
        return True
    if 3.0 < gpa <= 3.3 and grade == "B+":
        return True
    if 2.7 < gpa <= 3.0 and grade == "B":
        return True
    if 2.3 < gpa <= 2.7 and grade == "B-":
        return True
    if 2.0 < gpa <= 2.3 and grade == "C+":
        return True
    if 1.7 < gpa <= 2.0 and grade == "C":
        return True
    if 1.3 < gpa <= 1.7 and grade == "C-":
        return True
    if 1.0 < gpa <= 1.3 and grade == "D+":
        return True
    if 0.7 < gpa <= 1.0 and grade == "D":
        return True
    if 0.0 < gpa <= 0.7 and grade == "D-":
        return True
    if gpa == 0.0 and grade == "E":
        return True
    return False

def problem_81_pre(gpas: list) -> bool:
    return all(0 <= g <= 4 for g in gpas)

def problem_81_spec(gpas: list, grades: list) -> bool:
    if len(gpas) != len(grades):
        return False
    return all(grade_relation(g, gr) for g, gr in zip(gpas, grades))

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
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_81_pre(*input))

def postcondition(input, output) -> bool:
    if not isinstance(input, tuple):
        input = tuple(input)
    return bool(problem_81_spec(*input, output))

def numerical_letter_grade(*args):
    _input = tuple(args)
    assert precondition(_input)
    _output = _impl(*args)
    assert postcondition(_input, _output)
    return _output
