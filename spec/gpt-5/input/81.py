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
