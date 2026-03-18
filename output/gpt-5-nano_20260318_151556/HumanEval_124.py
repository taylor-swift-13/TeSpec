
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    if not isinstance(input[0], str):
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    if not isinstance(input, tuple) or len(input) != 1:
        return False
    s = input[0]
    if not isinstance(s, str):
        return False

    def is_valid_date_str(date_str):
        if len(date_str) != 10:
            return False
        if date_str[2] != '-' or date_str[5] != '-':
            return False
        mm = date_str[0:2]
        dd = date_str[3:5]
        yyyy = date_str[6:10]
        if not (mm.isdigit() and dd.isdigit() and yyyy.isdigit()):
            return False
        m = int(mm)
        d = int(dd)
        if m < 1 or m > 12:
            return False
        if m in (1, 3, 5, 7, 8, 10, 12):
            if d < 1 or d > 31:
                return False
        elif m in (4, 6, 9, 11):
            if d < 1 or d > 30:
                return False
        else:  # February
            if d < 1 or d > 29:
                return False
        return True

    expected = is_valid_date_str(s)
    return output == expected

def _impl(date):
    """
    You have to write a function which validates a given date string and
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

    valid_date('06/04/2020') => False
    """
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
