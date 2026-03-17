
def precondition(input):
    if len(input) != 1:
        return False
    grades = input[0]
    if not isinstance(grades, list):
        return False
    for g in grades:
        if not isinstance(g, (int, float)):
            return False
        if g < 0.0 or g > 4.0:
            return False
    return True


def postcondition(input, output):
    grades = input[0]
    if not isinstance(output, list):
        return False
    if len(output) != len(grades):
        return False
    
    valid_grades = ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C+', 'C', 'C-', 'D+', 'D', 'D-', 'E']
    
    for i, (gpa, letter) in enumerate(zip(grades, output)):
        if letter not in valid_grades:
            return False
        
        # Verify the mapping
        if gpa == 4.0:
            expected = 'A+'
        elif gpa > 3.7:
            expected = 'A'
        elif gpa > 3.3:
            expected = 'A-'
        elif gpa > 3.0:
            expected = 'B+'
        elif gpa > 2.7:
            expected = 'B'
        elif gpa > 2.3:
            expected = 'B-'
        elif gpa > 2.0:
            expected = 'C+'
        elif gpa > 1.7:
            expected = 'C'
        elif gpa > 1.3:
            expected = 'C-'
        elif gpa > 1.0:
            expected = 'D+'
        elif gpa > 0.7:
            expected = 'D'
        elif gpa > 0.0:
            expected = 'D-'
        else:
            expected = 'E'
        
        if letter != expected:
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
