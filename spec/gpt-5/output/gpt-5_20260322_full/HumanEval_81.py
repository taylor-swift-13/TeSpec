def to_letter_grade_spec(score, letter):
    if score == 4.0 and letter == "A+":
        return True
    elif 3.7 < score and score != 4.0 and letter == "A":
        return True
    elif 3.3 < score <= 3.7 and letter == "A-":
        return True
    elif 3.0 < score <= 3.3 and letter == "B+":
        return True
    elif 2.7 < score <= 3.0 and letter == "B":
        return True
    elif 2.3 < score <= 2.7 and letter == "B-":
        return True
    elif 2.0 < score <= 2.3 and letter == "C+":
        return True
    elif 1.7 < score <= 2.0 and letter == "C":
        return True
    elif 1.3 < score <= 1.7 and letter == "C-":
        return True
    elif 1.0 < score <= 1.3 and letter == "D+":
        return True
    elif 0.7 < score <= 1.0 and letter == "D":
        return True
    elif 0.0 < score <= 0.7 and letter == "D-":
        return True
    elif score <= 0.0 and letter == "E":
        return True
    return False

def numerical_letter_grade_spec(grades, letters):
    if len(grades) != len(letters):
        return False
    return all(to_letter_grade_spec(g, l) for g, l in zip(grades, letters))

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
