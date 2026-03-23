class PyValue:
    """Base class for PyValue inductive type."""
    pass

class PyInt(PyValue):
    """PyInt constructor: Z -> PyValue"""
    def __init__(self, n):
        self.n = n
    def __eq__(self, other):
        return isinstance(other, PyInt) and self.n == other.n

class PyFloat(PyValue):
    """PyFloat constructor: PyValue"""
    def __eq__(self, other):
        return isinstance(other, PyFloat)

class PyString(PyValue):
    """PyString constructor: PyValue"""
    def __eq__(self, other):
        return isinstance(other, PyString)

class PyDict(PyValue):
    """PyDict constructor: PyValue"""
    def __eq__(self, other):
        return isinstance(other, PyDict)

class PyList(PyValue):
    """PyList constructor: PyValue"""
    def __eq__(self, other):
        return isinstance(other, PyList)

class PyOther(PyValue):
    """PyOther constructor: PyValue"""
    def __eq__(self, other):
        return isinstance(other, PyOther)

def is_integer(v: PyValue) -> bool:
    """Checks if a PyValue is a PyInt."""
    return isinstance(v, PyInt)

def get_int(v: PyValue):
    """Returns the integer value if v is a PyInt, otherwise None."""
    if isinstance(v, PyInt):
        return v.n
    return None

def filter_integers_impl(values: list) -> list:
    """
    Filters a list of PyValue and returns a list of integers 
    extracted from PyInt values, preserving order.
    """
    return [v.n for v in values if isinstance(v, PyInt)]

def filter_integers_spec(values: list, result: list) -> bool:
    """
    Specification for filter_integers_impl.
    Returns True if result matches the implementation and satisfies the membership property.
    """
    # result = filter_integers_impl values
    if result != filter_integers_impl(values):
        return False
    
    # (forall z, In z result <-> exists v, In v values /\ v = PyInt z)
    
    # Check: In z result -> exists v, In v values /\ v = PyInt z
    for z in result:
        if not any(isinstance(v, PyInt) and v.n == z for v in values):
            return False
            
    # Check: (exists v, In v values /\ v = PyInt z) -> In z result
    for v in values:
        if isinstance(v, PyInt):
            # Here, z is v.n
            if v.n not in result:
                return False
                
    return True
