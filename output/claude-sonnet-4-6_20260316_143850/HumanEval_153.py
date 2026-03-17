
def precondition(input) -> bool:
    if len(input) != 2:
        return False
    class_name, extensions = input
    if not isinstance(class_name, str):
        return False
    if not isinstance(extensions, list):
        return False
    if len(extensions) == 0:
        return False
    for ext in extensions:
        if not isinstance(ext, str):
            return False
        if len(ext) == 0:
            return False
    return True


def postcondition(input, output) -> bool:
    if not isinstance(output, str):
        return False
    class_name, extensions = input
    if not output.startswith(class_name + '.'):
        return False
    suffix = output[len(class_name) + 1:]
    if suffix not in extensions:
        return False
    def strength(ext):
        cap = sum(1 for c in ext if c.isupper())
        sm = sum(1 for c in ext if c.islower())
        return cap - sm
    best_strength = max(strength(ext) for ext in extensions)
    if strength(suffix) != best_strength:
        return False
    for ext in extensions:
        if strength(ext) == best_strength:
            if ext != suffix:
                return False
            break
    return True

def _impl(class_name, extensions):
    """You will be given the name of a class (a string) and a list of extensions.
    The extensions are to be used to load additional classes to the class. The
    strength of the extension is as follows: Let CAP be the number of the uppercase
    letters in the extension's name, and let SM be the number of lowercase letters 
    in the extension's name, the strength is given by the fraction CAP - SM. 
    You should find the strongest extension and return a string in this 
    format: ClassName.StrongestExtensionName.
    If there are two or more extensions with the same strength, you should
    choose the one that comes first in the list.
    For example, if you are given "Slices" as the class and a list of the
    extensions: ['SErviNGSliCes', 'Cheese', 'StuFfed'] then you should
    return 'Slices.SErviNGSliCes' since 'SErviNGSliCes' is the strongest extension 
    (its strength is -1).
    Example:
    for Strongest_Extension('my_class', ['AA', 'Be', 'CC']) == 'my_class.AA'"""
    def strength(s: str) -> int:
        CAP, SM = 0, 0
        for ch in s:
            if ch.isupper(): CAP += 1
            if ch.islower(): SM += 1
        return CAP - SM
    max_strength = max(map(strength, extensions))
    for e in extensions:
        if strength(e) == max_strength:
            return class_name + "." + e

def Strongest_Extension(class_name, extensions):
    _input = (class_name, extensions)
    assert precondition(_input)
    _output = _impl(class_name, extensions)
    assert postcondition(_input, _output)
    return _output
