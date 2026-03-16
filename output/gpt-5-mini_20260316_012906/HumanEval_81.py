
import math

def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    grades = input[0]
    if not isinstance(grades, (list, tuple)):
        return False
    for g in grades:
        # reject booleans
        if isinstance(g, bool):
            return False
        if not isinstance(g, (int, float)):
            return False
        if not math.isfinite(g):
            return False
        # GPA should be within 0.0 to 4.0 inclusive
        if g < 0.0 or g > 4.0:
            return False
    return True

def postcondition(input, output):
    # If precondition does not hold, do not enforce postcondition here
    if not precondition(input):
        return True
    grades = input[0]
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != len(grades):
        return False
    def expected_letter(g):
        if g == 4.0:
            return 'A+'
        if g > 3.7:
            return 'A'
        if g > 3.3:
            return 'A-'
        if g > 3.0:
            return 'B+'
        if g > 2.7:
            return 'B'
        if g > 2.3:
            return 'B-'
        if g > 2.0:
            return 'C+'
        if g > 1.7:
            return 'C'
        if g > 1.3:
            return 'C-'
        if g > 1.0:
            return 'D+'
        if g > 0.7:
            return 'D'
        if g > 0.0:
            return 'D-'
        return 'E'
    allowed = {'A+','A','A-','B+','B','B-','C+','C','C-','D+','D','D-','E'}
    for g, out in zip(grades, output):
        if not isinstance(out, str):
            return False
        if out not in allowed:
            return False
        if out != expected_letter(g):
            return False
    return True

def _impl(grades):
    """It is the last week of the semester and the teacher has to give the grades
    to students. The teacher has been making her own algorithm for grading.
    The only problem is, she has lost the code she used for grading.
    She has given you a list of GPAs for some students and you have to write 
    a function that can output a list of letter grades using the following table:
             GPA       |    Letter grade
              4.0                A+
            > 3.7                A 
            > 3.3                A- 
            > 3.0                B+
            > 2.7                B 
            > 2.3                B-
            > 2.0                C+
            > 1.7                C
            > 1.3                C-
            > 1.0                D+ 
            > 0.7                D 
            > 0.0                D-
              0.0                E


    Example:
    grade_equation([4.0, 3, 1.7, 2, 3.5]) ==> ['A+', 'B', 'C-', 'C', 'A-']"""
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

def numerical_letter_grade(grades):
    _input = (grades,)
    assert precondition(_input)
    _output = _impl(grades)
    assert postcondition(_input, _output)
    return _output
