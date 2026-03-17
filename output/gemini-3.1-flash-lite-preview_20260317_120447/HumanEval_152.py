
def precondition(input):
    game, guess = input
    return (
        isinstance(game, list) and 
        isinstance(guess, list) and 
        len(game) == len(guess) and 
        all(isinstance(x, int) for x in game) and 
        all(isinstance(x, int) for x in guess)
    )

def postcondition(input, output):
    game, guess = input
    return (
        isinstance(output, list) and 
        len(output) == len(game) and 
        all(isinstance(x, int) and x >= 0 for x in output) and
        all(output[i] == (0 if game[i] == guess[i] else abs(game[i] - guess[i])) for i in range(len(game)))
    )

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
