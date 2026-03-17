
def precondition(input_args: tuple) -> bool:
    return len(input_args) == 1 and isinstance(input_args[0], str)

def postcondition(input_args: tuple, output: bool) -> bool:
    date = input_args[0]
    
    if not date:
        return output is False
    
    if len(date) != 10:
        return output is False
    
    if date[2] != '-' or date[5] != '-':
        return output is False
    
    mm_str = date[0:2]
    dd_str = date[3:5]
    yyyy_str = date[6:10]
    
    if not (mm_str.isdigit() and dd_str.isdigit() and yyyy_str.isdigit()):
        return output is False
    
    mm = int(mm_str)
    dd = int(dd_str)
    yyyy = int(yyyy_str)
    
    if mm < 1 or mm > 12:
        return output is False
    
    if mm in [1, 3, 5, 7, 8, 10, 12]:
        max_days = 31
    elif mm in [4, 6, 9, 11]:
        max_days = 30
    elif mm == 2:
        max_days = 29
    else:
        return output is False
        
    if dd < 1 or dd > max_days:
        return output is False
        
    return output is True

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
