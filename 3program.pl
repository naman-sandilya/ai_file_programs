/*
 * Queries:- 
	 * c_to_f(32, X).
 	 * freezing(40).
*/

c_to_f(C, F):-
F is C * 9/5 + 32.

freezing(F):-
F =< 32.
