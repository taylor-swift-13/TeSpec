
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    grades = input[0]
    if not isinstance(grades, (list, tuple)):
        return False
    for g in grades:
        if not isinstance(g, (int, float)):
            return False
        v = float(g)
        if v < 0.0 or v > 4.0:
            return False
        if v != v:
            return False
    return True

def postcondition(input, output):
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    grades = input[0]
    if not isinstance(grades, (list, tuple)):
        return False
    if not isinstance(output, list):
        return False
    expected = []
    for g in grades:
        v = float(g)
        if v == 4.0:
            expected.append('A+')
        elif v > 3.7:
            expected.append('A')
        elif v > 3.3:
            expected.append('A-')
        elif v > 3.0:
            expected.append('B+')
        elif v > 2.7:
            expected.append('B')
        elif v > 2.3:
            expected.append('B-')
        elif v > 2.0:
            expected.append('C+')
        elif v > 1.7:
            expected.append('C')
        elif v > 1.3:
            expected.append('C-')
        elif v > 1.0:
            expected.append('D+')
        elif v > 0.7:
            expected.append('D')
        elif v > 0.0:
            expected.append('D-')
        else:
            expected.append('E')
    if len(output) != len(expected):
        return False
    for a, b in zip(output, expected):
        if a != b:
            return False
    return True

def _impl(grades):
    """
    It is the last week of the semester and the teacher has to give the grades
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
    grade_equation([4.0, 3, 1.7, 2, 3.5]) ==> ['A+', 'B', 'C-', 'C', 'A-']
    """
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
