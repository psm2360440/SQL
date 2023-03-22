/*1-1. EMP 테이블에서 부서번호, 평균 급여, 최고 급여, 최저급여, 사원수를 출력
* 단 평균 급여 출력 시 소수점을 제외하고 각 부서번호별로 출력 (그룹화) */
SELECT DEPTNO
	 , ROUND(AVG(SAL)) AS AVG_SAL
	 , ROUND(MAX(SAL)) AS MAX_SAL
	 , ROUND(MIN(SAL)) AS MIN_SAL
	 , ROUND(COUNT(ENAME)) AS CNT
 FROM EMP
  GROUP BY DEPTNO;
  
/*1-2. 같은 직책에 있는 사원이 3명 이상인 경우 직책과 인원수를 출력 (JOB으로 그룹화)*/
SELECT JOB
	 , COUNT(ENAME) AS "COUNT(*)"
 FROM EMP
 GROUP BY JOB
 HAVING COUNT(ENAME) >= 3

 /*1-3. 사원들의 입사년도를 기준으로 부서별로 몇 명이 입사했는지 출력 */
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_DATE
	 , DEPTNO
	 , COUNT(*) AS CNT
  FROM EMP
  GROUP BY TO_CHAR(HIREDATE, 'YYYY'), DEPTNO;
  
/*1-4. 추가 수당(COMM)을 받는 사원수와 받지 않는 사원수를 출력*/
SELECT NVL2(COMM, 'Y', 'N') AS EXIST_COMM
	 , COUNT(*)
 FROM EMP
 GROUP BY NVL2(COMM, 'Y', 'N');
 
 /*1-5. 각 부서의 입사 연도별 사원수, 최고급여, 급여합, 평균 급여를 출력하고
  * 각 부서별 소계와 총계를 함께 출력 (ROLLUP 함수로 그룹화)*/
SELECT DEPTNO
 	 , TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR
 	 , COUNT(*) AS CNT
 	 , MAX(SAL) AS MAX_SAL
 	 , SUM(SAL) AS SUM_SAL
 	 , AVG(SAL) AS AVG_SAL
 FROM EMP
 GROUP BY ROLLUP (DEPTNO, TO_CHAR(HIREDATE, 'YYYY'))
 
/*2-1. INNER-JOIN 방식으로 급여(SAL)이 2000 초과인 사원들의 부서 정보, 사원정보를 출력
 	(1) 오라클 SQL*/
SELECT E.DEPTNO
 	 , D.DNAME
 	 , E.EMPNO
 	 , E.ENAME
 	 , E.SAL
 FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
	AND E.SAL > 2000;
 
/*2-1. (2) 표준 SQL */
SELECT E.DEPTNO
 	 , D.DNAME
 	 , E.EMPNO
 	 , E.ENAME
 	 , E.SAL
 FROM EMP E JOIN DEPT D
 			ON E.DEPTNO = D.DEPTNO
 			AND E.SAL > 2000
 
/*2-2. NATURAL-JOIN 각 부서별 평균 급여, 최대 급여, 최소 급여 사원수를 출력 */
SELECT D.DEPTNO
	  ,D.DNAME
	  ,AVG(E.SAL)
	  ,MAX(E.SAL)
	  ,MIN(E.SAL)
	  ,COUNT(E.SAL)
 FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
 GROUP BY D.DEPTNO, D.DNAME;
​
/* EMP와 DEPT 테이블을 사용하여 다음과 같이 출력하는 SQL문을 작성하세요. */
/*2-3. 모든 부서 정보와 사원 정보를 부서정보를 기준으로 조인(right-join) */
SELECT D.DEPTNO  
	 , D.DNAME
	 , E.EMPNO 
	 , E.ENAME 
	 , E.JOB 
	 , E.SAL
	FROM EMP E RIGHT JOIN DEPT D 
	ON E.DEPTNO =D.DEPTNO
	ORDER BY E.DEPTNO,E.EMPNO;
       
/*2-4. 부서정보, 사원정보, 급여 등급 정보를 JOIN하여 각 사원의 직속 상관의 정보를 */
/* 부서번호, 사원번호 순으로 정렬하여 출력(right-join)*/
SELECT D.DEPTNO 
	 , D.DNAME 
	 , E1.EMPNO 
	 , E1.ENAME 
	 , E1.MGR 
	 , E1.SAL 
	 , E1.DEPTNO 
	 , S.LOSAL 
	 , S.HISAL 
	 , S.GRADE
	 , E2.ENAME  AS MGR_NAME
	 , E2.EMPNO AS MGR_NO
	FROM EMP e1 RIGHT JOIN DEPT d ON E1.DEPTNO  = D.DEPTNO 
		LEFT OUTER JOIN SALGRADE s  ON E1.SAL BETWEEN S.LOSAL AND S.HISAL 
		LEFT OUTER JOIN EMP e2 ON E1.MGR =E2.EMPNO 
	ORDER BY D.DEPTNO,E1.EMPNO

/*3.EMP와 DEPT 테이블을 사용하여 다음과 같이 출력하는 SQL문을 작성하세요*
 *3-1. 'ALLEN'과 같은 직책(JOB)인 직원들의 사원명, 사원정보, 부서정보를 출력 */
SELECT E.JOB
	 , E.ENAME
 	 , E.EMPNO
 	 , E.SAL
 	 , D.DEPTNO
 	 , D.DNAME
 FROM EMP E JOIN DEPT D ON E.DEPTNO = D.DEPTNO
  WHERE E.JOB = (SELECT JOB
  				 FROM EMP
  				 WHERE ENAME = 'ALLEN');
  				 
/*3-2. 전체 사원의 평균 급여(SAL)보다 높은 급여를 받는 사원 정보, 부서정보, 급여 출력 */
SELECT E.EMPNO
 	 , E.ENAME
 	 , D.DNAME
 	 , E.HIREDATE
 	 , D.LOC
 	 , E.SAL
 	 , S.GRADE 
 FROM EMP E JOIN DEPT D
 			ON E.DEPTNO = D.DEPTNO
 			JOIN SALGRADE S
 			ON E.SAL BETWEEN S.LOSAL AND S.HISAL
 WHERE E.SAL > (SELECT AVG(SAL) FROM EMP)
 ORDER BY E.SAL DESC, E.ENAME DESC;

/*3-3. 부서코드 10인 부서에 근무하는 사원 중 부서코드 30번 부서에 존재하지 않는 직책을 가진 사원들의 정보를 출력 */
SELECT E.EMPNO
	 , E.ENAME
	 , E.JOB
	 , E.DEPTNO
	 , D.DNAME
	 , D.LOC 
 FROM (SELECT *
 		FROM EMP
 		WHERE DEPTNO = 10) E
 	 , DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.JOB NOT IN (SELECT JOB
 						FROM EMP
 						WHERE DEPTNO = 30);

/*3-4. 직책이 SALESMAN인 사람들의 최고 급여보다 높은 급여를 받는 사원들의 정보를 출력
 * 다중행 함수를 사용한 경우 MAX()사용 */
SELECT E.EMPNO
	 , E.ENAME
	 , E.SAL
	 , S.GRADE
 FROM EMP E JOIN SALGRADE S
			ON E.SAL BETWEEN S.LOSAL AND S.HISAL
 WHERE E.SAL > (SELECT MAX(SAL)
 				FROM EMP
 				WHERE JOB = 'SALESMAN'); 
 			
/*3-5. 위의 4번을 다중행 함수를 사용하지 않고 ALL 키워드를 사용하여 결과를 출력 */
SELECT E.EMPNO
	 , E.ENAME
	 , E.SAL
	 , S.GRADE
 FROM EMP E JOIN SALGRADE S
			ON E.SAL BETWEEN S.LOSAL AND S.HISAL
 WHERE E.SAL > ALL(SELECT SAL
 					FROM EMP
 					WHERE JOB = 'SALESMAN');
 				
/* 
* 이론과제 답안 제출 먼저 드립니다.
* Q 2-1
* (1) 테이블 
* (2) 외래 키(FK, Foreign Key)
* (3) 널(NULL)
*
* Q 2-2
* (1) 문자셋(CharacterSet)
* (2) 문자셋(CharSet)
*
* Q 2-3
* (1) VARCHAR2
* (2) CHAR
*
* Q 2-4
* (1) 제약 조건
* (2) 기본키(Primary Key, PK)
* (3) 외래키(Foreign Key, FK)
*
* Q 2-5
* (1) 무결성(Integrity) 
* (2) 무결성
* (3) 무결성
*
* Q 2-6
* (1) Unique
* (2) Not Null
* (3) Index
*/