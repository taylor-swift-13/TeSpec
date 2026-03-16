
def precondition(input):
    date = input[0]
    if not isinstance(date, str):
        return False
    if len(date) != 10:
        return False
    if date[2] != '-' or date[5] != '-':
        return False
    parts = date.split('-')
    if len(parts) != 3:
        return False
    if not (parts[0].isdigit() and parts[1].isdigit() and parts[2].isdigit()):
        return False
    if len(parts[0]) != 2 or len(parts[1]) != 2 or len(parts[2]) != 4:
        return False
    return True

def postcondition(input, output):
    if not isinstance(output, bool):
        return False
    date = input[0]
    parts = date.split('-')
    month = int(parts[0])
    day = int(parts[1])
    year = int(parts[2])
    
    if output:
        if month < 1 or month > 12:
            return False
        if day < 1:
            return False
        if month in [1,3,5,7,8,10,12]:
            if day > 31:
                return False
        elif month in [4,6,9,11]:
            if day > 30:
                return False
        elif month == 2:
            if day > 29:
                return False
        return True
    else:
        if month < 1 or month > 12:
            return True
        if day < 1:
            return True
        if month in [1,3,5,7,8,10,12]:
            if day > 31:
                return True
        elif month in [4,6,9,11]:
            if day > 30:
                return True
        elif month == 2:
            if day > 29:
                return True
        return False

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
