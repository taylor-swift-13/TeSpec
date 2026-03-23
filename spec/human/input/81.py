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

def _orig_problem_81_pre(gpas: list) -> bool:
    return all((0 <= g <= 4 for g in gpas))

def _orig_problem_81_spec(gpas: list, grades: list) -> bool:
    if len(gpas) != len(grades):
        return False
    return all((grade_relation(g, gr) for (g, gr) in zip(gpas, grades)))

def problem_81_pre(grades):
    return bool(_orig_problem_81_pre(grades))

def problem_81_spec(grades, output):
    return bool(_orig_problem_81_spec(grades, output))
