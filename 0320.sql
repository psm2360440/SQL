/* 갑자기 이걸 왜 하는지 모르겠으나 중구난방으로 여기저기 돌아다니다가 
 * 금요일에 했어야 했던 오라클 함수 정리를 하기 시작하셔서 타이핑을 시작한다!
 */
 
/* 오라클 내장 함수*/
SELECT *
FROM v$sqlfn_metadata v
WHERE v.name = 'nvl';


/*문자열 함수
 *UPPER(A): A를 대문자로
 *LOWER(A): A를 소문자로 */
SELECT ENAME
 	 , UPPER(ENAME) AS TP_UPPER_ENAME
 	 , LOWER(ENAME) AS TP_LOWER_ENAME
 FROM EMP;

SELECT *
 FROM EMP e
 WHERE UPPER(ENAME) = UPPER('SCOTT');
 

/*TRIM */
SELECT '[' || TRIM('__ORACLE__') ||']' AS TRIM
	 , '[' || TRIM(LEADING FROM'__ORACLE__') ||']' AS LEADING
	 , '[' || TRIM(TRAILING FROM'__ORACLE__') ||']' AS TRAILING
	 , '[' || TRIM(BOTH FROM'__ORACLE__') ||']' AS BOTH
FROM DUAL;


/*CONCAT CONCAT(A, B) : A+B (R공백도 붙이기 가능!)*/
SELECT EMPNO
	 , ENAME
	 , CONCAT(EMPNO, ENAME) AS "이름이랑_사번_붙이기"
	 , CONCAT(EMPNO, ' ') AS "사번에_공백_붙이기"
 FROM EMP
 WHERE ENAME = UPPER('SMITH');

/*REPLACE REPLACE(A, B, C): 문자열A에서 B를 C로 대체! */
SELECT '010-1234-5678' AS MOBILE_PHONE
	 , REPLACE ('010-1234-5678', '-',' ') AS REPLACE
 FROM DUAL;


/* LPAD & RPAD 
 * LPAD(A, B, C): A의 왼쪽에 'B-"A의 자릿수"'에 'C'를 반복하여 붙인다
 * RPAD(A, B, C): A의 오른쪽에 'B-"A의 자릿수"'에 'C'를 반복하여 붙인다*/
SELECT LPAD('ORA_1234_XE', 20) AS LPAD_20
	 , RPAD('ORA_1234_XE', 20) AS RPAD_20
FROM DUAL;

SELECT RPAD('901013-', 14, '*') AS 선미_마스킹하기
	 , RPAD('910417-', 14, '*') AS 보고_마스킹하기
 FROM DUAL;


/*-----------------------------------------------------------------------------------------------------------------------*/
/*NUMBER 숫자를 다루는 함수들

정수(INTEGER), 부동소수(FLOAT) = 소숫점이 있는 숫자
부동소수의 경우, 소수점 이하 정밀도(PRECISION) 차이가 발생*/

/*TRUNC(A, B) 1)B>0일 때, 소숫점 B째자리까지 출력하고 버림/ 2)B<0일 때, A* 10의 B승*/
SELECT TRUNC(3.1233456677) AS TRUNC
	 , TRUNC(232.213123123123, 0) AS T_0
	 , TRUNC(23423.234122312, 1) AS T_1
	 , TRUNC(23423.234234, -1) AS MINUS_1
	 , TRUNC(234234234.234234234,-3) AS MINUS_3 
 FROM DUAL;

/*CEIL CEIL(A)-> A에 가장 가까운 큰 정수(천장) / FLOOR(A)->A에 가장 가까운 작은 정수*(바닥)*/
SELECT CEIL(3.14) AS CEIL
	 , FLOOR(3.14) AS FLOOR
	 , CEIL (-3.14) AS M_CEIL
	 , FLOOR(-3.14) AS M_FLOOR
 FROM DUAL;

/* MOD(A, B) -> A를 B로 나눈 나머지
SELECT MOD(15, 6)
 	 , MOD(10,2)
 	 , MOD(11,2)
FROM DUAL;


/*  POWER(A, B) -> A의 B승*/
SELECT POWER(3,2)
	 , POWER(-3,3)
	 , POWER(10,3)
	 , POWER(0.5, 4)
 FROM DUAL;
 
/*절대값 함수*/
SELECT ABS(-1000)
	 , ABS(100)
 FROM DUAL;

/*+,- 부호 반환 함수*/
SELECT SIGN(-1000)
	 , SIGN(1000)
	 , SIGN(0)
	 , SIGN(-1)
	 , SIGN(-10000000)
 FROM DUAL;

/*날짜 함수*/
SELECT SYSDATE AS NOW
	 , SYSDATE -1 AS YESTERDAY
	 , SYSDATE +10 AS TEN_DAYS_FROM_NOW
 FROM DUAL;


/*ADD_MONTHS(날짜, 숫자 또는 :MONTH) : 해당 날짜에 숫자로 된 달을 더하거나 ':MONTH'일 경우 팝업창이 뜨는데 숫자를 입력 그 숫자만큼의 달을 더하라*/
SELECT ADD_MONTHS(SYSDATE, :MONTH)
/*팝업창에 24를 치셨는데 아마 24개월을 더하라는 것 같다 그렇게 출력되어 나온다 설명은 없다*/
 FROM DUAL;

/*MONTHS_BETWEEN(날짜A, 날짜B) : 날짜A와 날짜B 사이의 월 수를 출력 */
SELECT ENAME
	 , HIREDATE
	 , SYSDATE
	 , MONTHS_BETWEEN(HIREDATE, SYSDATE)/12 AS YEAR1
	 , MONTHS_BETWEEN(SYSDATE, HIREDATE)/12 AS YEAR2
	 ,TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)/12) AS YEAR3
FROM EMP;

/*EXTRACT(YEAR/MONTH/DAY FROM 날짜) : 해당 날짜로부터 년/월/일을 출력하라*/
SELECT ENAME
 	 , EXTRACT(YEAR FROM HIREDATE) AS Y
 	 , EXTRACT(MONTH FROM HIREDATE) AS M
 	 , EXTRACT(DAY FROM HIREDATE) AS D
 FROM EMP;

/*LAST_DAY(DATE) : 해당 날짜가 속한 달의 마지막 날
 *NEXT_DAY(A, B) : 해당 날짜 기준 다음 B요일 출력(DBEAVER 언어 설정에 따라서 입력해야만 함! 안 알려주셔서 뻘짓함)
 */
SELECT SYSDATE
	 , NEXT_DAY(SYSDATE, '월요일')
	 , LAST_DAY(SYSDATE)
 FROM DUAL;

/*ROUND(날짜A, 'CC'): 세기 반올림
 *ROUND(날짜A, 'YYYY'): 연 반올림
 *ROUND(날짜A, 'Q'): 분기 반올림
 *ROUND(날짜A, 'DDD'): 날짜 반올림
 *ROUND(날짜A, 'HH'): 시간 반올림
 **/

SELECT SYSDATE
	 , ROUND(TO_DATE('2049-12-31'),'CC') AS FORMAT_CC
	 , ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY
	 , ROUND(SYSDATE, 'Q') AS FORMAT_Q
	 , ROUND(SYSDATE, 'DDD') AS FORMAT_DDD
	 , ROUND(SYSDATE, 'HH') AS FORMAT_HH
 FROM DUAL;

/*암묵적 형변환
 * EMPNO: NUMBER, '500': STRING
 * 암묵적 형변환을 통하여 계산돤 8288이 출력됨!
 * 설명을 해주시진 않았지만~ 아마도 그런 의미일 것 같다~*/
SELECT EMPNO
	 , ENAME
	 , EMPNO + '500'
 FROM EMP 
 WHERE ENAME = 'SCOTT';

/* 이게 잘못된 형변환이라는데 그래서 어느부분이 잘못된 형변환이죠?*/
SELECT 1300 - '1500'
	 ,'1300' + 1500
 FROM DUAL;


/*명시적 형변환
 * TO_CHAR(날짜, 원하는 형식(EX. 'YYYY'/'MM'/'DD'/'HH'/'MI'/'SS'))
 */
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') AS CURRENT_DATETIME
 FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYY') AS CURRENT_YEAR
	 , TO_CHAR(SYSDATE, 'MM') AS CURRENT_MONTH
	 , TO_CHAR(SYSDATE, 'DD') AS CURRENT_DAY
	 , TO_CHAR(SYSDATE, 'HH') AS CURRENT_HOUR
	 , TO_CHAR(SYSDATE, 'MI') AS CURRENT_MINUTE
	 , TO_CHAR(SYSDATE, 'SS') AS CURRENT_SECOND
 FROM DUAL;

SELECT SYSDATE
	 , TO_CHAR(SYSDATE, 'MON', 'NLS_LANGUAGE=KOREAN') AS MON_KR
	 , TO_CHAR(SYSDATE, 'MM', 'NLS_LANGUAGE=KOREAN') AS MM_KR
	 , TO_CHAR(SYSDATE, 'MON', 'NLS_LANGUAGE=JAPANESE') AS MON_JP
	 , TO_CHAR(SYSDATE, 'MON', 'NLS_LANGUAGE=ENGLISH') AS MON_EN
 FROM DUAL;

/*날짜 TO_CHAR 함수*/
SELECT SYSDATE
	 , TO_CHAR(SYSDATE, 'HH:MI:SS') AS HH24MISS
	 , TO_CHAR(SYSDATE, 'HH12:MI:SS PM') AS HH24MISS_AM
	 , TO_CHAR(SYSDATE, 'HH12:MI:SS A.M.') AS HH24MISS_AMPM
 FROM DUAL;


SELECT TO_NUMBER('10,000', '999,999,999') AS I_DO_NOT_KNOW
 FROM DUAL;


SELECT  *
 FROM EMP WHERE HIREDATE > TO_DATE('1981/07/01','YYYY/MM/DD');
 

SELECT TO_DATE('49/12/10', 'YY/MM/DD') AS YY_YEAR 49
 FROM DUAL;
 


/* RR은 2000년대 이전의 연도를 가져올 때 씀!*/
SELECT TO_DATE('1991-04-11', 'RR/MM/DD')
	 , TO_DATE('2021-04-11', 'YY/MM/DD')
 FROM DUAL;
 

/* NULL 값 : 알 수 없는 값 계산이 불가능한 값
NULL 값 비교는  IS NULL<>IS NOT NULL

NVL(입력값, NULL인 경우 대체할 값)
NVL2(입력값, NULL이 아닌 경우의 값, NULL일 경우의 값) */

SELECT EMPNO
	 , ENAME
	 , SAL
	 , COMM
	 , SAL + COMM 
	 , NVL(COMM, 0)
	 , SAL + NVL(COMM, 0)
 FROM EMP;

SELECT EMPNO
	 , ENAME
	 , COMM 
	 , NVL2(COMM, 'O', 'X')
	 , NVL2(COMM, SAL*12+COMM, SAl*12) AS annsal
 FROM EMP;
 
SELECT EMPNO
	 , ENAME
	 , SAL
	 , COMM
	 , SAL + COMM 
	 , NULLIF (COMM, 0)
	 , SAL + NULLIF(COMM, 0)
 FROM EMP;
 

/*DECODE(입력 컬럼값, '비교값1', 처리1,
 * 					'비교값2', 처리2,
 * 					'.....', 처리N) AS 별칭
 * ***무슨 말인지 모르겠으나 잘 짜여진 것은 DECODE라는 말을 하셨음... 왜 그런지는 추후에 GPT한테 묻는 게 나을 듯...
 * 
 * 
 * CASE 컬럼값
 * 		WHEN '값1' THEN 처리1
 * 		WHEN '값2' THEN 처리2
 * 		WHEN '값N' THEN 처리N
 * 		ELSE 처리N+1
 * 		END AS 별칭
 */