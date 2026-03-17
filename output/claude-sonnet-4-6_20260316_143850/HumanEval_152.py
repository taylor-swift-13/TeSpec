
def precondition(args):
    if len(args) != 2:
        return False
    game, guess = args
    if not isinstance(game, (list, tuple)) or not isinstance(guess, (list, tuple)):
        return False
    if len(game) != len(guess):
        return False
    for x in game:
        if not isinstance(x, (int, float)):
            return False
    for x in guess:
        if not isinstance(x, (int, float)):
            return False
    return True


def postcondition(args, output):
    game, guess = args
    if not isinstance(output, (list, tuple)):
        return False
    if len(output) != len(game):
        return False
    for i in range(len(game)):
        expected = abs(game[i] - guess[i])
        if output[i] != expected:
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
