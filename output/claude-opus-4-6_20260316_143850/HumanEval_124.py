
def precondition(input):
    (date,) = input
    return isinstance(date, str)

def postcondition(input, output):
    (date,) = input
    assert isinstance(output, bool)
    
    # If the string is empty, result must be False
    if date.strip() == '':
        return output == False
    
    # Check format: must be mm-dd-yyyy with exactly two hyphens
    parts = date.strip().split('-')
    
    # If not exactly 3 parts, should be False
    if len(parts) != 3:
        return output == False
    
    mm_str, dd_str, yyyy_str = parts
    
    # Each part must be purely digits
    if not (mm_str.isdigit() and dd_str.isdigit() and yyyy_str.isdigit()):
        return output == False
    
    # Check lengths (mm should be 2, dd should be 2, yyyy should be 4 based on format mm-dd-yyyy)
    # But the description doesn't strictly enforce leading zeros beyond the format hint,
    # so let's just validate the numeric values.
    
    try:
        month = int(mm_str)
        day = int(dd_str)
        year = int(yyyy_str)
    except ValueError:
        return output == False
    
    # Validate month range
    if month < 1 or month > 12:
        return output == False
    
    # Validate day range based on month
    if month in (1, 3, 5, 7, 8, 10, 12):
        max_day = 31
    elif month in (4, 6, 9, 11):
        max_day = 30
    else:  # month == 2
        max_day = 29
    
    if day < 1 or day > max_day:
        return output == False
    
    # If all checks pass, output should be True
    return output == True

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
