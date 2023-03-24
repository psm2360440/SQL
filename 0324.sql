/*03월 24일 수업 내용*/

SELECT *
 FROM (SELECT DEPTNO
	 		, MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK" --쌍따옴표 소문자 별칭
	 		, MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALES"
	 		, MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESI"
			, MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MAN"
			, MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANA"
			FROM EMP
			GROUP BY DEPTNO
			ORDER BY DEPTNO)
 UNPIVOT (SAL FRO JOB ION("CLERK", "SALES", "[RESI", "MAN", "ANA"))
 ORDER BY DEPTNO, JOB;
 
CREATE TABLE ... AS -- ... 테이블 이름
();

CREATE VIEW ... AS -- ... 뷰 이름
();

/* INNER JOIN 1:1 테이블간 연결을 통해 추가 정보를 제공하는 목적이 대부분*/
SELECT *
 FROM EMP E JOIN DEPT D
 	ON E.DEPTNO = D.DEPTNO;
 	
 
 SELECT E.EMPNO
 	  , E.ENAME
 	  , E.JOB
 	  , E.HIREDATE
 	  , E.SAL
 	  , E.COMM
 	  , D.DEPTNO
 	  , D.NAME
 	  , D.LOC
 FROM EMP E JOIN DEPT D ---INNER JOIN 교집합
 	ON E.DEPTNO = D.DEPTNO ---직원과 부서 (1:1 관계)
 	
 	
WITH EMP_SAL AS (SELECT E.EMPNO
					  , E.ENAME
					  , S.GRADE AS GRADE
					  , E.JOB
					  , E.HIREDATE
					  , E.SAL
					  , E.COMM
					  , E.DEPTNO
					  , S.LOSAL
					  , S.HISAL
				 FROM EMP E, SALGRADE S
				 WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL)
			EMP_DEPT AS (SELECT E.EMPNO
							  , E.ENAME
							  , E.JOB
							  , E.HIREDATE
							  , E.SAL
							  , E.COMM
							  , D.DEPTNO
							  , D.DNAME 
							  , D.LOC
							FROM EMP E JOIN DEPT D
							ON E.DEPTNO = D.DEPTNO);
							
						
/*SELF-JOIN : 하나의 테이블에 성질이 동일한 2개 이상의 컬럼의 관계를 이용하여 원하는 레코드의 관계를 산출하고 싶은 경우 사용
 * EMP: EMPNO (사번)과 MGR (상사의 사번) 동일
 * */
						
SELECT E1.EMPNO
	 , E1.ENAME
	 , E1.MGR
	 , E2.EMPNO AS MGR_EMPNO
	 , E2.ENAME AS MGR_ENAME
 FROM EMP E1 JOIN EMP E2
 	ON E1.MGR = E2.EMPNO --EMP 테이블에 사번의 이름은 있으나, MGR
						


/*RIGHT-JOIN : 직원 사번과 상사 사번의 관계를 계층적으로 확인할 수 있는 방법*/
SELECT E1.EMPNO
	 , E1.ENAME
	 , E1.MGR
	 , E2.EMPNO AS MGR_EMPNO
	 , E2.ENAME AS MGR_ENAME
 FROM EMP E1  RIGHT JOIN EMP E2
 	ON E1.MGR = E2.EMPNO; --MGR NULL인 직원도 모두 출력
 	
 
SELECT 
 FROM EMP E1 RIGHT JOIN DEPT D
 				ON E1.DEPTNO = D.DEPTNO 
 			 LEFT JOIN SALGRADE S
 			 	ON E1.SAL BETWEEN S.LOSAL AND S.HISAL
 			 LEFT JOIN EMP E2
 			 	ON E1.MGR = E2.MGR;
						
/* SUB-QUERY  서브쿼리 (쿼리 문에 사용되는 쿼리)
 * 
 * 서브쿼리 결과 : 단일 값 출력, 다중형 (하나의 컬럼에 행 배열)
 * 				다중열(두 개 이상의 컬럼별 행 배열) */
 
SELECT DEPTNO
	 , MAX(SAL)
 FROM EMP
 GROUP BY DEPTNO;

SELECT DEPTNO
	 , SAL
 FROM EMP;
 

ALTER TABLE EMP_NEW 
 ADD TEL VARCHAR(20);
 
COMMIT;

ALTER TABLE EMP_NEW  MODIFY EMPNO NUMBER(5) -- 기존 4자리 정수에서 다행히 5자리로 확대


