/*
* Queries:-
	n_queen(number_of_queens, X).
	X = [] (return solution)
*/


use_module(library(lists)).

/*
	N-queens problem solved in Prolog (SWI-Prolog).
	Usage es: n_queen(4,X).
*/

n_queen(N, Solution) :-
%create a list of N dummy variabiles
length(Solution, N),

queen(Solution, N). %search for a configuration of N queens


%returns a list of integer from K to N included es up2N(1,3,X) X = [1,2,3]
up2N(N,N,[N]) :-!.
up2N(K,N,[K|Tail]) :- K < N, K1 is K+1, up2N(K1, N, Tail).


queen([],_). %No queens is a solution for any N queens problem. All queens are in a safe position.

queen([Q|Qlist],N) :-

queen(Qlist, N), %first we solve the subproblem

%we then generate all possible positions for queen Q
up2N(1,N,Candidate_positions_for_queenQ),

%we pick one of such position
member(Q, Candidate_positions_for_queenQ),

%we check whether the queen Q is safe
check_solution(Q,Qlist, 1).



check_solution(_,[], _).

check_solution(Q,[Q1|Qlist],Xdist) :-
Q =\= Q1, %not on the same row
Test is abs(Q1-Q),
Test =\= Xdist, %diagonal distance
Xdist1 is Xdist + 1,
check_solution(Q,Qlist,Xdist1).
