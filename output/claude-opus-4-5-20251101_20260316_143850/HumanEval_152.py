
def precondition(args) -> bool:
    if len(args) != 2:
        return False
    game, guess = args
    
    # Both must be lists
    if not isinstance(game, list) or not isinstance(guess, list):
        return False
    
    # Both lists must have equal length
    if len(game) != len(guess):
        return False
    
    # All elements in game must be integers or floats
    for item in game:
        if not isinstance(item, (int, float)):
            return False
    
    # All elements in guess must be integers or floats
    for item in guess:
        if not isinstance(item, (int, float)):
            return False
    
    return True


def postcondition(args, output) -> bool:
    game, guess = args
    
    # Output must be a list
    if not isinstance(output, list):
        return False
    
    # Output must have the same length as input lists
    if len(output) != len(game):
        return False
    
    # Each element in output must be the absolute difference between game and guess
    for i in range(len(game)):
        expected = abs(game[i] - guess[i])
        if output[i] != expected:
            return False
    
    # All output values must be non-negative
    for val in output:
        if val < 0:
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
