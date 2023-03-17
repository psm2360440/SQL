SELECT ENAME, JOB, SAL, DEPTNO
FROM EMP WHERE DEPTNO = 10
AND JOB = 'ANALYST';


SELECT * FROM EMP WHERE SAL = 5000;

SELECT * FROM EMP WHERE SAL = (SELECT MAX(SAL)
FROM EMP);


SELECT *
FROM EMP
WHERE JOB IN('MANAGER', 'KING', 'CLERK');

SELECT * FROM EMP WHERE SAL = (SELECT MAX(SAL)
FROM EMP);


SELECT * FROM EMP
WHERE ENAME LIKE 'M%';

SELECT * FROM EMP 
WHERE ENAME LIKE '_L%';

SELECT * FROM EMP  
WHERE ENAME LIKE '%A_M%';

SELECT *FROM EMP 
WHERE ENAME NOT LIKE '%S';



SELECT *
FROM EMP
WHERE COMM = NULL;


SELECT *
FROM EMP
WHERE MGR IS NULL;


SELECT *
FROM EMP
WHERE COMM IS NULL;

SELECT EMPNO, ENAME, SAL, DEPTNO, JOB
FROM EMP
WHERE JOB = 'CLERK'

UNION

SELECT EMPNO, ENAME, SAL, DEPTNO, JOB
FROM EMP
WHERE JOB = 'SALESMAN';


SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP WHERE DEPTNO = 10

UNION 

SELECT EMPNO, ENAME, SAL
FROM EMP 
WHERE DEPTNO = 20;

SELECT  EMPNO, ENAME, SAL, DEPTNO
FROM EMP 
WHERE DEPTNO = 10
UNION ALL
SELECT EMPNO, ENAME, SAL, DEPTNO 
FROM EMP 
WHERE DEPTNO = 10;



SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP 
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
FROM EMP 
WHERE DEPTNO = 10;



SELECT * FROM V$SQLFN_METADATA;


SELECT *
FROM EMP
WHERE UPPER(ENAME) = UPPER('SCOTT');

SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
FROM EMP;
SELECT ENAME, LENGTH(ENAME) FROM EMP 
WHERE LENGTH(ENAME) >=5;

SELECT ENAME, JOB, MGR, DEPTNO
FROM EMP
WHERE UPPER(ENAME) LIKE UPPER('%c%');


SELECT ENAME, LENGTH(ENAME)
FROM EMP 
WHERE LENGTH(ENAME) >= 5;





SELECT JOB
, SUBSTR(JOB, 1, 2), SUBSTR(JOB, 3,2), SUBSTR(JOB, 5)
FROM EMP;

SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1
,INSTR('HELLO ORACLE!', 'L', 5) AS INSTR_2
,INSTR('HELLO ORACLE!', 'L', 2, 2) AS INSTR_3
FROM DUAL;



SELECT '010-1234-5678' AS REPLACE_BEFORE
	,REPLACE ('010-1234-5678', '-','') AS REPLACE_1
		,REPLACE ('010-1234-5678', '-') AS REPLACE_2
		FROM DUAL;
		
	SELECT EMPNO, ENAME, CONCAT(EMPNO, ENAME),
	CONCAT(EMPNO, CONCAT(':', ENAME))
	FROM EMP
	WHERE ENAME = 'SMITH';
	
SELECT '['||TRIM('__Oracle__')||']'AS TRIM,
 '['||TRIM(LEADING FROM'__Oracle__')||']'AS TRIM_LEADING,
  '['||TRIM(TRAILING FROM'__Oracle__')||']'AS TRIM_TRAILING,
   '['||TRIM(BOTH FROM'__Oracle__')||']'AS TRIM_BOTH
   FROM DUAL;
  
  
  SELECT ROUND(1234.5678) AS R, ROUND(1234.5678,0) AS R_0,
  ROUND(1234.5678) AS R, ROUND(1234.5678,0) AS R_0,

  
  SELECT SYSDATE AS NOW
 ,SYSDATE-1 AS YESTERDAY
 ,SYSDATE+1 AS TOMORROW
 FROM DUAL;


SELECT SYSDATE, ADD_MONTHS(SYSDATE,3)
FROM DUAL;

SELECT  EMPNO, ENAME, HIREDATE,
ADD_MONTHS(HIREDATE, 12*20) AS WORK10YEAR
FROM EMP;

SELECT EMPNO, ENAME, HIREDATE, SYSDATE 
FROM EMP  WHERE ADD_MONTHS(HIREDATE, 12*40)>SYSDATE;

SELECT SYSDATE, SYSDATE-1, SYSDATE-3
FROM DUAL;

SELECT SYSDATE, NEXT_DAY(SYSDATE,'월요일'), LAST_DAY(SYSDATE)
FROM DUAL;

SELECT ENAME
,EXTRACT(YEAR FROM HIREDATE) AS Y
,EXTRACT(MONTH FROM HIREDATE) AS M
,EXTRACT(DAY FROM HIREDATE) AS D
FROM EMP;


SELECT SYSDATE, ROUND(SYSDATE,'CC') AS FORMAT_CC,
ROUND(SYSDATE,'YYYY') AS FORMAT_YYYY,
ROUND(SYSDATE,'Q') AS FORMAT_Q,
ROUND(SYSDATE,'DDD') AS FORMAT_DDD,
ROUND(SYSDATE,'HH') AS FORMAT_HH
FROM DUAL;


SELECT EMPNO, ENAME, SAL, COMM, SAL+COMM 
, NVL(COMM, 0)
, SAL+NVL(COMM, 0)
FROM EMP;

SELECT EMPNO, ENAME, COMM 
,NVL2(COMM, 'O', 'X')
,NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNSAL
FROM EMP;

SELECT *
FROM EMP 
WHERE HIREDATE > TO_DATE('1981/07/01', 'YYYY/MM/DD');


SELECT EMPNO, ENAME, JOB, SAL
,DECODE(JOB,
'MANAGER', SAL*0.2,
'SALESMAN',SAL*0.3,
'ANALYST', SAL*0.05,
SAL*0.1) AS BONUS
FROM EMP;

SELECT EMPNO, ENAME, JOB, SAL
,CASE JOB
WHEN 'MANAGER' THEN SAL*0.2
WHEN 'SALESMAN' THEN SAL*0.3
WHEN 'ANALYST' THEN SAL*0.05
ELSE SAL*0.1
END AS BONUS
FROM EMP;


SELECT *
FROM EMP, DEPT
WHERE EMP.DEPTNO = DEPT.DEPTNO ORDER BY EMPNO;



SELECT*
FROM EMP E JOIN DEPT D 
			ON(E.DEPTNO = D.DEPTNO)
ORDER BY EMPNO;

SELECT *
FROM EMP E JOIN DEPT D
USING(DEPTNO)
ORDER BY E.EMPNO;

SELECT *
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO 
ORDER BY EMPNO;

