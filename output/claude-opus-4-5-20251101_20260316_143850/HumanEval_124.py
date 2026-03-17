
def precondition(args):
    (date,) = args
    # The input should be a string
    return isinstance(date, str)


def postcondition(args, output):
    (date,) = args
    # Output should be a boolean
    if not isinstance(output, bool):
        return False
    
    # If output is True, verify the date is actually valid
    if output:
        # Must not be empty
        if not date or date.strip() == "":
            return False
        
        # Must contain exactly two hyphens for mm-dd-yyyy format
        if date.count('-') != 2:
            return False
        
        parts = date.split('-')
        if len(parts) != 3:
            return False
        
        mm, dd, yyyy = parts
        
        # Each part should be numeric
        if not (mm.isdigit() and dd.isdigit() and yyyy.isdigit()):
            return False
        
        # Check format: mm should be 2 digits, dd should be 2 digits, yyyy should be 4 digits
        if len(mm) != 2 or len(dd) != 2 or len(yyyy) != 4:
            return False
        
        month = int(mm)
        day = int(dd)
        
        # Month must be 1-12
        if month < 1 or month > 12:
            return False
        
        # Day must be at least 1
        if day < 1:
            return False
        
        # Check day limits based on month
        if month in [1, 3, 5, 7, 8, 10, 12]:
            if day > 31:
                return False
        elif month in [4, 6, 9, 11]:
            if day > 30:
                return False
        elif month == 2:
            if day > 29:
                return False
    
    # If output is False, we accept it (we don't need to verify all invalid cases)
    return True

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
