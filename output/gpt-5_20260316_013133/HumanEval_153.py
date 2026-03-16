
def precondition(input):
    if not isinstance(input, tuple) or len(input) != 2:
        return False
    class_name, extensions = input
    if not isinstance(class_name, str):
        return False
    if not isinstance(extensions, (list, tuple)):
        return False
    if len(extensions) < 1:
        return False
    for e in extensions:
        if not isinstance(e, str):
            return False
    return True

def postcondition(input, output):
    if not precondition(input):
        return True
    class_name, extensions = input
    if not isinstance(output, str):
        return False

    def strength(ext):
        cap = sum(1 for c in ext if 'A' <= c <= 'Z')
        sm = sum(1 for c in ext if 'a' <= c <= 'z')
        return cap - sm

    exts = list(extensions)
    strengths = [strength(e) for e in exts]
    max_strength = max(strengths)
    for idx, s in enumerate(strengths):
        if s == max_strength:
            best_ext = exts[idx]
            break
    expected = class_name + "." + best_ext
    return output == expected

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
