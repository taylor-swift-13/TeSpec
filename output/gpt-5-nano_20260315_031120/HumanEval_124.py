
def precondition(input) -> bool:
    if not isinstance(input, tuple):
        return False
    if len(input) != 1:
        return False
    arg = input[0]
    if not isinstance(arg, str):
        return False
    return True

def postcondition(input, output) -> bool:
    if not precondition(input):
        return False
    if not isinstance(output, bool):
        return False

    s = input[0]
    parts = s.split('-')
    if len(parts) != 3:
        expected = False
    else:
        m_str, d_str, y_str = parts
        if not (len(m_str) == 2 and len(d_str) == 2 and len(y_str) == 4):
            expected = False
        elif not (m_str.isdigit() and d_str.isdigit() and y_str.isdigit()):
            expected = False
        else:
            month = int(m_str)
            day = int(d_str)
            if not (1 <= month <= 12):
                expected = False
            else:
                if month in (1, 3, 5, 7, 8, 10, 12):
                    max_day = 31
                elif month in (4, 6, 9, 11):
                    max_day = 30
                else:
                    max_day = 29
                expected = (1 <= day <= max_day)
    return output == expected

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
