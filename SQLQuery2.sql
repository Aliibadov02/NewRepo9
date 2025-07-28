-- 1
SELECT DISTINCT LR.Name
FROM Lectures L
JOIN Teachers T ON L.TeacherId = T.Id
JOIN Schedules S ON S.LectureId = L.Id
JOIN LectureRooms LR ON S.LectureRoomId = LR.Id
WHERE T.Name = 'Edward' AND T.Surname = 'Hopper';

-- 2
SELECT DISTINCT T.Name + ' ' + T.Surname AS AssistantFullName
FROM Assistants A
JOIN Teachers T ON A.TeacherId = T.Id
JOIN Lectures L ON L.TeacherId = T.Id
JOIN GroupsLectures GL ON GL.LectureId = L.Id
JOIN Groups G ON GL.GroupId = G.Id
WHERE G.Name = 'F505';

-- 3
SELECT DISTINCT Sub.Name
FROM Lectures L
JOIN Teachers T ON L.TeacherId = T.Id
JOIN Subjects Sub ON L.SubjectId = Sub.Id
JOIN GroupsLectures GL ON GL.LectureId = L.Id
JOIN Groups G ON GL.GroupId = G.Id
WHERE T.Name = 'Alex' AND T.Surname = 'Carmack' AND G.Year = 5;

-- 4
SELECT DISTINCT T.Name + ' ' + T.Surname AS TeacherFullName
FROM Teachers T
WHERE T.Id NOT IN (
SELECT DISTINCT L.TeacherId
FROM Lectures L
JOIN Schedules S ON S.LectureId = L.Id
WHERE S.DayOfWeek = 1
);

-- 5
SELECT LR.Name, LR.Building
FROM LectureRooms LR
WHERE NOT EXISTS (
SELECT 1
FROM Schedules S
WHERE S.LectureRoomId = LR.Id AND S.DayOfWeek = 3 AND S.Week = 2 AND S.Class = 3
);

-- 6
SELECT DISTINCT T.Name + ' ' + T.Surname AS TeacherFullName
FROM Teachers T
JOIN Departments D ON D.FacultyId = (
SELECT F.Id FROM Faculties F WHERE F.Name = 'Computer Science'
)
WHERE T.Id IN (
SELECT TeacherId FROM Lectures
)
AND T.Id NOT IN (
SELECT C.TeacherId
FROM Curators C
JOIN GroupsCurators GC ON GC.CuratorId = C.Id
JOIN Groups G ON GC.GroupId = G.Id
JOIN Departments Dep ON G.DepartmentId = Dep.Id
WHERE Dep.Name = 'Software Development'
);

-- 7
SELECT DISTINCT Building FROM Faculties
UNION
SELECT DISTINCT Building FROM Departments
UNION
SELECT DISTINCT Building FROM LectureRooms;

-- 8
SELECT T.Name + ' ' + T.Surname AS FullName, 1 AS Rank FROM Teachers T
JOIN Deans D ON D.TeacherId = T.Id
UNION
SELECT T.Name + ' ' + T.Surname, 2 FROM Teachers T
JOIN Heads H ON H.TeacherId = T.Id
UNION
SELECT T.Name + ' ' + T.Surname, 3 FROM Teachers T
WHERE T.Id NOT IN (
SELECT TeacherId FROM Deans
UNION
SELECT TeacherId FROM Heads
UNION
SELECT TeacherId FROM Curators
UNION
SELECT TeacherId FROM Assistants
)
UNION
SELECT T.Name + ' ' + T.Surname, 4 FROM Teachers T
JOIN Curators C ON C.TeacherId = T.Id
UNION
SELECT T.Name + ' ' + T.Surname, 5 FROM Teachers T
JOIN Assistants A ON A.TeacherId = T.Id
ORDER BY Rank, FullName;

-- 9
SELECT DISTINCT S.DayOfWeek
FROM Schedules S
JOIN LectureRooms LR ON S.LectureRoomId = LR.Id
WHERE LR.Name IN ('A311','A104') AND LR.Building = 6;
