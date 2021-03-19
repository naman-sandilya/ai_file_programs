/*
* Queries:-
	get_road(start, end, Visited, Distance).
	-- returns distance and visited places.
*/

road(abes,crossing, 9).
road(lal_kuan,abes, 3).
road(lal_kuan,crossing, 6).
road(lal_kuan,vijay_nagar, 5).
road(vijay_nagar,lal_kuan, 5).
road(pratap_vihar,lal_kuan, 4).
road(pratap_vihar,vijay_nagar, 8).

get_road(Start, End, Visited, Result) :-
    get_road(Start, End, [Start], 0, Visited, Result).

get_road(Start, End, Waypoints, DistanceAcc, Visited, TotalDistance) :-
    road(Start, End, Distance),
    reverse([End|Waypoints], Visited),
    TotalDistance is DistanceAcc + Distance.

get_road(Start, End, Waypoints, DistanceAcc, Visited, TotalDistance) :-
	road(Start, Waypoint, Distance),
	\+ member(Waypoint, Waypoints),
	NewDistanceAcc is DistanceAcc + Distance,
	get_road(Waypoint, End, [Waypoint|Waypoints], NewDistanceAcc, Visited, TotalDistance).
