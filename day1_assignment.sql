/* A. 이론문제
1-1 
(1)논리설계 (2)데이터 모델링
1-2 
(1)E-R 모델 (2)E-R 모델 (3)Entity
1-3 
(1)E-R Diagram (2)관계
1-4 
(1)카디널리티 (2)옵셔널리티
1-5 
(1)스키마 (2) 테이블
1-6 
(1)Table (2)Index (3)Sequence



B. 실습문제
EMP 테이블에서 다음과 같이 출력하세요(컬럼 순서도 동일하게 출력) */
SELECT EMPNO AS EMPLOYEE_NO
	 , ENAME AS EMPLOYEE_NAME
	 , JOB, MGR AS MANAGER
	 , HIREDATE
	 , SAL AS SALARY
	 , COMM AS COMMISSION
	 , DEPTNO AS DEPARTMENT_NO
 FROM EMP
 ORDER BY DEPTNO DESC
 	 , ENAME;
 	 
 	
/*다음과 같이 NULL값을 비교하세요(NULL값에 대한 이해)
 * 1. COMM IS NULL이고 SAL>NULL 보다 큰 경우는? */
SELECT *
 FROM EMP
 WHERE COMM IS NULL
   AND SAL > NULL;
  
  
/* 2. MGR와 COMM 모두가 NULL인 직원은 누구일까? */
SELECT *
 FROM EMP
 WHERE MGR IS NULL
   AND COMM IS NULL;
 
  
/*EMP 테이블에서 다음과 같이 출력하세요! (컬럼 순서도 동일하게 출력)
 1. 사원명(ENAME)이 S로 끝나는 직원만 출력*/
SELECT *
 FROM EMP 
 WHERE ENAME LIKE ('%S');


/* 2. JOB이 SALESMAN 이고 부서번호가 30인 경우*/
SELECT *
 FROM EMP
 WHERE JOB ='SALESMAN'
   AND DEPTNO = 30;
  
  
/* 3. 부서번호(DEPTNO)가 20 또는 30이고 월급(SAL)이 2000 초과하는 경우*/
SELECT *
 FROM EMP
 WHERE DEPTNO IN (20, 30)
   AND SAL > 2000;
  
  
/* 4. 앞의 3번을 UNION 키워드를 사용하는 경우(DEPTNO 20인 경우와 30인 경우를 UNION)*/
SELECT *
 FROM EMP
 WHERE DEPTNO = 20
   AND SAL > 2000

UNION 

SELECT *
 FROM EMP
 WHERE DEPTNO = 30
   AND SAL > 2000;
   
  
/* 5. COMM(추가수당)이 없고 매니저가 아닌 상급자가 있는 직원(MGR IS NOT NULL)중에서
 * 	 직책이 MANAGER, CLERK이고 이름의 두번째 글자가 L이 아닌 경우*/
SELECT *
 FROM EMP
 WHERE COMM IS NULL
   AND MGR IS NOT NULL
   AND JOB IN ('MANAGER', 'CLERK')
   AND ENAME NOT LIKE ('_L%');
   
  
/* EMP 테이블을 사용하여 다음과 같이 출력하는 SQL문을 작성하세요
* 1. 사원명(ENAME)이 6글자 이상인 경우에 사원번호와 직원명을 다음과 같이 마스킹 처리*/
SELECT EMPNO
 	 , ENAME
 	 , RPAD(SUBSTR(EMPNO, 1, 2),LENGTH(EMPNO), '*') AS EMPNO_마스킹_처리
 	 , RPAD(SUBSTR(ENAME, 1, 1),LENGTH(ENAME), '*') AS ENAME_마스킹_처리
 FROM EMP
 WHERE LENGTH(ENAME) >= 6;


/* 2. JOB이 SALESMAN, CLERK에 해당하는 경우, 매월 평균적으로 20일 근무하고,
 * 	 일 평균 근무 시간이 8시간인 경우 일 평균 급여와 시급 기준 급여를 계산한 후
 *   월급을 기준으로 오름차순으로 정렬하세요*/
SELECT EMPNO
	 , ENAME
	 , JOB
	 , SAL
	 , (SAL / 20) AS DAY_PER_SAL
	 , (SAL / 20 / 8) AS HOUR_PER_SAL
 FROM EMP
 WHERE JOB IN ('SALESMAN', 'CLERK')
 ORDER BY SAL;


/*EMP 테이블을 사용하여 다음과 같이 출력하는 SQL문을 작성하세요
 * 3. 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 되는 날짜 YYYY-MM-DD를 구하고
 *    추가 수당(COMM)이 없는 겨우, 'N/A'로 출력*/
SELECT EMPNO
	 , ENAME
	 ,TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'), 'YYYY-MM-DD') AS REGULAR_TURNOVER_DATE
	 ,REPLACE(COMM, NULL, 'N/A') AS COMM
 FROM EMP;
 

/*4. 직속상관이 없는 경우 0000, 앞 두 자리가 75인 경우 5555, 앞 두 자리가 76인 경우 6666,
 *  앞 두 자리가 77인 경우 7777, 앞 두 자리가 78인 경우 8888, 기타의 경우 9999를 출력*/
SELECT EMPNO
	 , ENAME
	 , MGR
	 , CASE WHEN (MGR IS NULL) THEN '0000'
		 	WHEN SUBSTR(EMPNO, 1, 2) = '75' THEN '5555'
	 		WHEN SUBSTR(EMPNO, 1, 2) = '76' THEN '6666'
	 		WHEN SUBSTR(EMPNO, 1, 2) = '77' THEN '7777'
	 		WHEN SUBSTR(EMPNO, 1, 2) = '78' THEN '8888'
	 ELSE '9999'
	 END AS CHG_MGR
 FROM EMP;