
def precondition(input) -> bool:
    return isinstance(input, tuple) and len(input) == 1 and isinstance(input[0], str)

def postcondition(input, output) -> bool:
    if not precondition(input):
        return True
    if not isinstance(output, bool):
        return False
    s = input[0]
    valid = False
    if isinstance(s, str) and len(s) > 0:
        if len(s) == 10 and s[2] == '-' and s[5] == '-' and s[:2].isdigit() and s[3:5].isdigit() and s[6:].isdigit():
            month = int(s[:2])
            day = int(s[3:5])
            # year is ensured to be 4 digits by format check; value unconstrained
            if 1 <= month <= 12:
                if month in {1, 3, 5, 7, 8, 10, 12}:
                    valid = 1 <= day <= 31
                elif month in {4, 6, 9, 11}:
                    valid = 1 <= day <= 30
                else:
                    valid = 1 <= day <= 29
            else:
                valid = False
        else:
            valid = False
    else:
        valid = False
    return output == valid

def _impl(date):
    """You have to write a function which validates a given date string and
    returns True if the date is valid otherwise False.
    The date is valid if all of the following rules are satisfied:
    1. The date string is not empty.
    2. The number of days is not less than 1 or higher than 31 days for months 1,3,5,7,8,10,12. And the number of days is not less than 1 or higher than 30 days for months 4,6,9,11. And, the number of days is not less than 1 or higher than 29 for the month 2.
    3. The months should not be less than 1 or higher than 12.
    4. The date should be in the format: mm-dd-yyyy

    for example: 
    valid_date('03-11-2000') => True

    valid_date('15-01-2012') => False

    valid_date('04-0-2040') => False

    valid_date('06-04-2020') => True

    valid_date('06/04/2020') => False"""
    days = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    if len(date) != 10: return False
    if date[2] != "-" or date[5] != "-": return False
    m, d, y = date[:2], date[3:5], date[6:]
    if not m.isdigit() or not d.isdigit() or not y.isdigit(): return False
    m, d = int(m), int(d)
    if not 1 <= m <= 12: return False
    if not 1 <= d <= days[m-1]: return False
    return True

def valid_date(date):
    _input = (date,)
    assert precondition(_input)
    _output = _impl(date)
    assert postcondition(_input, _output)
    return _output
