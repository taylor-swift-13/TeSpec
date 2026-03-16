
import math
import numbers
from typing import Sequence

def _is_number(x):
    return isinstance(x, numbers.Real) and not isinstance(x, bool) and math.isfinite(x)

def precondition(input) -> bool:
    # input is expected to be a tuple/list of positional args: (game, guess)
    if not isinstance(input, (tuple, list)):
        return False
    if len(input) != 2:
        return False
    game, guess = input[0], input[1]
    # game and guess should be sequences (lists or tuples) of numbers (ints/floats), not strings
    if not isinstance(game, (list, tuple)) or not isinstance(guess, (list, tuple)):
        return False
    if len(game) != len(guess):
        return False
    for a, b in zip(game, guess):
        if not _is_number(a) or not _is_number(b):
            return False
    return True

def postcondition(input, output) -> bool:
    # only check when precondition holds
    if not precondition(input):
        return True
    game, guess = input[0], input[1]
    # output should be a sequence of same length
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != len(game):
        return False
    for i, (g, gs) in enumerate(zip(game, guess)):
        out_val = output[i]
        if not _is_number(out_val):
            return False
        # determine expected value: 0 if equal, else absolute difference
        if math.isclose(g, gs, rel_tol=1e-9, abs_tol=1e-12):
            expected = 0.0
        else:
            expected = abs(g - gs)
        if not math.isclose(out_val, expected, rel_tol=1e-9, abs_tol=1e-12):
            return False
    return True

def _impl(game,guess):
    """I think we all remember that feeling when the result of some long-awaited
    event is finally known. The feelings and thoughts you have at that moment are
    definitely worth noting down and comparing.
    Your task is to determine if a person correctly guessed the results of a number of matches.
    You are given two arrays of scores and guesses of equal length, where each index shows a match. 
    Return an array of the same length denoting how far off each guess was. If they have guessed correctly,
    the value is 0, and if not, the value is the absolute difference between the guess and the score.


    example:

    compare([1,2,3,4,5,1],[1,2,3,4,2,-2]) -> [0,0,0,0,3,3]
    compare([0,5,0,0,0,4],[4,1,1,0,0,-2]) -> [4,4,1,0,0,6]"""
    return [abs(game[i] - guess[i]) for i in range(len(game))]

def compare(game,guess):
    _input = (game, guess)
    assert precondition(_input)
    _output = _impl(game, guess)
    assert postcondition(_input, _output)
    return _output
