# Matlab_2048_Solver
# James Strawson 2016

Matlab implementation of 2048 and a recursive algorithm that plays until game over.

The basic method of play is to recursively try every move a few steps ahead set by the variable 'recursive_depth'. The sequence which gives the best score at the end of 'recursive_depth' moves is chosen and it's first move is played. Since the game randomly fills an empty tile with a 2 or 4, each possible outcome is played and the average score of all possible outcomes in used to determine statistically the best move.

This is rather inefficient and runs slowly for recursive depths above 3. To accelerate the process the recursive depth is automatically reduced if there are lots of open spaces or the user is not yet close to getting the next big tile.

