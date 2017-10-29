We are looking for a program that manages disjointed intervals of integers. E.g.: `[[1, 3], [4, 6]]` is
a valid object gives two intervals. `[[1, 3], [3, 6]]` is not a valid object because it is not disjoint. `[[1,
6]]` is the intended result.

Empty array `[]` means no interval, it is the default/start state.

We want you to implement two functions:
* add(from, to)
* remove(from, to)

Here is an example sequence:
1. Start: []
2. Call: add(1, 5) => [[1, 5]]
3. Call: remove(2, 3) => [[1, 2], [3, 5]]
4. Call: add(6, 8) => [[1, 2], [3, 5], [6, 8]]
5. Call: remove(4, 7) => [[1, 2], [3, 4], [7, 8]]
6. Call: add(2, 7) => [[1, 8]]
7. etc.

This is not a very simple problem, please take your time and try to get the code bug free if you
can. There is no time requirement, and you can use any programming language.
To give you some context of a practical application for such a solution, you may imagine it being
used to define mechanic’s availability for a day. A key responsibility of the Engineering team
here at Your Mechanic is ensuring timely matching of mechanic availability to customer demand
for a service and the mechanic’s calendar is an integral part of that process.

As an example, these intervals could be thought of as representing ranges of time within a day,
in terms of the number of minutes from midnight. E.g: the interval array: [[0, 62], [150, 180]]
would represent the ranges of 12:00 AM to 1:02 AM and 2:30 AM to 3:00 AM. The add/remove
functions can be thought of as adding or removing available time from the day’s schedule. E.g:
remove(420, 480) implies that the entire period from 7:00 AM to 8:00 AM is now unavailable on
the schedule.

While the mechanic calendar is one application of the algorithm, it may not be the only one.
Please consider the above illustration only as one example among many.
