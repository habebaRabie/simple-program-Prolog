:- [students_courses].

digitWord(0, 'zero').
digitWord(1, 'one').
digitWord(2, 'two').
digitWord(3, 'three').
digitWord(4, 'four').
digitWord(5, 'five').
digitWord(6, 'six').
digitWord(7, 'seven').
digitWord(8, 'eight').
digitWord(9, 'nine').


member1(X, [X|_]).         
                         
member1(X, [_|Tail]) :-   
  member1(X, Tail).
  
append1([], L,L).
append1([H|T],L2,[H|L3]):-append1(T,L2,L3).


%Task 1
studentsInCourse(X, Students):-
studentsInCourse(X,Students,[] ).

studentsInCourse(X,Students,List ):-
	student(Z, X, Y),
	\+(member1([Z,Y], List)), !,
	append1(List,[[Z,Y]],Nlist),
	studentsInCourse(X,Students,Nlist).
studentsInCourse(_,Students,Students ).



%Task 2
numStudents(X, Num):-
	numStudents(X,0,[],Num).

numStudents(X,N,List,Num):-
    student(Z, X, _),
    \+(member1(Z, List)), !,
    append1(List, [Z] ,Nlist),
    NewN is N+1,
    numStudents(X,NewN,Nlist,Num).

numStudents(_,Num,_,Num).


% Task 3
maxStudentGrade(X, N):-
student(X, _, N),
\+ (student(Y, _, M),
    X = Y,
    N < M).



%Task 4
gradeInWords(X, Y, DigitsWords):-
    student(X,Y,Z),
    Z1 is Z//10,
    Z2 is Z mod 10,
    digitWord(Z1,A),
    digitWord(Z2,B),
    (
        Z1 =:= 0 -> append1([],[B],DigitsWords);
        append1([],[A, B],DigitsWords)
    ).



%Task 5
courseTaken(Student,CourseName,List):-
student(Student ,CourseName,Grade),
\+(member1(CourseName, List)),
Grade > 49 .

firstPrerequisite(CourseName, Start):-
 firstPrerequisite(CourseName, Start,[]).
 
firstPrerequisite(CourseName, Start , List):-
        prerequisite(X,CourseName),
        \+(member1(X, List)),!,
        append1([X],List,Nlist),
        firstPrerequisite(X,Start,Nlist).

firstPrerequisite(Start,Start,_).

remainingCourses(StudntId, Y, RemainingCourses):-
 firstPrerequisite(Y, S),
 student(StudntId,S,G),
 G > 49 ->
    remainingCourses(StudntId,Y,[],RemainingCourses);
    false.

remainingCourses(StudntId,Y,List,RemainingCourses):-
    prerequisite(Z,Y),
    \+(courseTaken(StudntId,Z,List)),!,
    append1([Z],List,Nlist),
    remainingCourses(StudntId,Z,Nlist,RemainingCourses).
remainingCourses(_,_,RemainingCourses,RemainingCourses).
