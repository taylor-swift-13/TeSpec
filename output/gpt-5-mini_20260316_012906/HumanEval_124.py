
def precondition(input):
    if not isinstance(input, tuple):
        return False
    if len(input) < 1:
        return False
    return isinstance(input[0], str)

def postcondition(input, output):
    if not precondition(input):
        return True
    date = input[0]
    if not isinstance(output, bool):
        return False

    def expected(s):
        if not isinstance(s, str):
            return False
        if s == "":
            return False
        parts = s.split('-')
        if len(parts) != 3:
            return False
        m_str, d_str, y_str = parts
        if not (m_str.isdigit() and d_str.isdigit() and y_str.isdigit()):
            return False
        try:
            m = int(m_str)
            d = int(d_str)
            # year presence checked by isdigit above; no further constraints
        except Exception:
            return False
        if not (1 <= m <= 12):
            return False
        if m in (1, 3, 5, 7, 8, 10, 12):
            maxd = 31
        elif m in (4, 6, 9, 11):
            maxd = 30
        elif m == 2:
            maxd = 29
        else:
            return False
        if not (1 <= d <= maxd):
            return False
        return True

    return output == expected(date)

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
