SELECT quantityOnHand FROM item
WHERE itemDescription = 'bottle of antibiotics';

SELECT volunteerName FROM volunteer
WHERE volunteerTelephone NOT LIke '2%'
AND volunteerName NOT LIKE '%Jones';

SELECT volunteer.volunteerName FROM volunteer
JOIN assignment ON volunteer.volunteerId = assignment.volunteerId
JOIN task ON assignment.taskCode = task.taskCode
JOIN task_type ON task.taskTypeId = task_type.taskTypeId
WHERE task_type.taskTypeName = 'transporting';

SELECT task.taskDescription FROM task
LEFT JOIN assignment ON task.taskCode = assignment.taskCode
WHERE assignment.taskCode IS NULL;

SELECT package_type.packageTypeName
FROM item
JOIN package_contents ON item.itemId = package_contents.itemId
JOIN package ON package_contents.packageId = package.packageId
JOIN package_type ON package.packageTypeId = package_type.packageTypeId
WHERE item.itemDescription LIKE '%bottle%'
GROUP BY package_type.packageTypeName;

SELECT item.itemDescription FROM item
LEFT JOIN package_contents ON item.itemId = package_contents.itemId
WHERE package_contents.packageId IS NULL;

SELECT task.taskDescription FROM task
JOIN assignment ON assignment.taskCode = task.taskCode
JOIN volunteer ON volunteer.volunteerId = assignment.volunteerId
WHERE volunteer.volunteerAddress LIKE '%NJ'
GROUP BY task.taskCode;

SELECT volunteer.volunteerName FROM volunteer
JOIN assignment ON volunteer.volunteerId = assignment.volunteerId
WHERE assignment.startDateTime >= '2021-01-01 00:00:00' 
AND assignment.startDateTime <= '2021-06-30 23:59:59';

SELECT DISTINCT volunteer.volunteerName FROM volunteer
JOIN assignment ON assignment.volunteerId = volunteer.volunteerId
JOIN package ON package.taskCode = assignment.taskCode
JOIN package_contents ON package_contents.packageId = package.packageId
JOIN item ON item.itemId = package_contents.itemId
WHERE item.itemDescription = 'can of spam';

SELECT item.itemDescription FROM item
JOIN package_contents ON package_contents.itemId = item.itemId
WHERE item.itemValue * package_contents.itemQuantity = 100;

SELECT task_status.taskStatusName, COUNT(DISTINCT assignment.volunteerId) AS volunteerNum
From task_status
JOIN task ON task.taskStatusId = task_status.taskStatusId
JOIN assignment ON task.taskCode = assignment.taskCode
GROUP BY task_status.taskStatusName
ORDER BY volunteerNum DESC;

SELECT taskCode, SUM(packageWeight) AS totalWeight
FROM package
GROUP BY taskCode
ORDER BY totalWeight DESC LIMIT 1;

SELECT COUNT(*) FROM task
JOIN task_type ON task_type.taskTypeId = task.taskTypeId
WHERE task_type.taskTypeName != 'packing';

SELECT item.itemDescription FROM item
JOIN package_contents ON package_contents.itemId = item.itemId
JOIN package ON package.packageId = package_contents.packageId
JOIN assignment ON assignment.taskCode = package.taskCode
GROUP BY item.itemId
HAVING COUNT(DISTINCT assignment.volunteerId) < 3;

SELECT package_contents.packageId, SUM(item.itemValue * package_contents.itemQuantity) AS value 
FROM package_contents
JOIN item ON item.itemId = package_contents.itemId
GROUP BY package_contents.packageId
HAVING value > 100
ORDER BY value ASC;
