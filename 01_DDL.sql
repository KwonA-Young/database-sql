/* 실행은 ctrl + Enter
데이터베이스 생성 명령
데이터베이스 내부에 테이블들이 적재되기 때문에
먼저 데이터베이스를 생성해야 한다.
DEFAULT CHARACTER SET UTF8; 을 붙여주시면 한글설정이 됩니다.
내가 지정하는 이름 등을 제외한 쿼리문은 대문자로만 작성하는 것이 일반적입니다. */
CREATE DATABASE bitcamp06 DEFAULT CHARACTER SET UTF8;

/* 데이터베이스 조회는 좌측 상단의 Schemas를 클릭하고 새로고침 후에
bitcamp06이 생성된게 확인되었으면 우클릭 -> set as default schemas
선택시 볼드처리되고, 지금부터 적는 쿼리문은 해당 DB에 들어간다는 의미. */

/* 해당 DB에 접근할 수 있는 사용자 계정 생성
USER - id 역할, IDENTIFIED BY - pw 역할 */
CREATE USER 'adminid' IDENTIFIED BY '2023502';

/* 사용자에게 권한 부여 : GRANT 주고싶은기능1, 기능2....	
만약 모든 권한을 주고싶다면 ALL PREVILEGES(모든권한) TO 부여받을 계정명 */
GRANT ALL PRIVILEGES ON bitcamp06.* to 'adminid';

/* 테이블 생성 명령
PRIMARY KEY : 칼럼의 주요 키를 뜻하고, 중복 데이터 방지도 겸함
모든 테이블의 칼럼 중 하나는 반드시 PK 속성이 부여되어 있어야 함.
NOT NULL : 해당 칼럼을 비워둘 수 없다는 의미
UNIQUE : 중복 데이터가 입력되는 것을 방지 */

CREATE TABLE users(
	u_number INT(3) PRIMARY KEY,
    u_id VARCHAR(20) UNIQUE NOT NULL,
    u_name VARCHAR(30) NOT NULL,
    email VARCHAR(80)
);

/* 데이터 적재
INSERT INTO 테이블명 (컬럼1, 컬럼2....) VALUES(값1, 값2...);
만약 모든 칼럼에 값을 넣는다면 위 구문에서 테이블명 다음 오는 컬럼명을 생략할 수 있음.
*/
INSERT INTO users(u_number, u_id, u_name, email) VALUES (1, 'abc123', '가나다', NULL); 
INSERT INTO users VALUES (2, 'abc456', '마바사', 'abc@ab.com');

/* 데이터 조회
SELECT * FROM 테이블명; 을 적으면
해당 테이블에 적재된 데이터를 조회할 수 있습니다.
SELECT (컬럼명1, 컬럼명2...) FROM 테이블명;
을 이용해서 특정 칼럼에 적재된 데이터만 조회할 수도 있다. */
SELECT * FROM users; 

/* 문제
3번 유저를 임의로 추가해주세요.
이메일, 회원번호, 아이디 순으로 세 칼럼만 조회하는 구문 */
INSERT INTO users(u_id, u_number, u_name) VALUES ('qwer1234', 3, '쿼리개발');
SELECT email, u_number, u_id FROM users;

/* 계정을 하나 더 생성하겠습니다.
이번 계정은 SELECT 권한만 주겠습니다. */
CREATE USER 'adminid2' IDENTIFIED BY '2023502';
GRANT SELECT ON bitcamp06.* to 'adminid2';

-- users 테이블에 주소 칼럼을 추가해보겠습니다.
-- ALTER TABLE 테이블명 ADD ((추카칼럼명 자료타입(크기));
ALTER TABLE users ADD (u_address varchar(30)); 

SELECT * FROM users;

-- users 테이블에서 이메일 칼럼을 삭제해주세요.
ALTER TABLE users DROP COLUMN email;
SELECT * FROM users;

-- u_address 칼럼에 UNIQUE 제약조건 별칭 부여해서 걸기. 
ALTER TABLE users ADD CONSTRAINT u_address_unique UNIQUE (u_address);

-- INSERT INTO 구문으로 7, 8번 유저를 추가해주시되
-- 주소는 둘 다 '강남구'로 넣으려고 시도해보세요.
INSERT INTO users VALUES (7, 'sevenseven', '칠칠이', '강남구');
INSERT INTO users VALUES (8, 'eighteight', '팔팔이', '강남구');

SELECT * FROM users;

-- 주소에 걸린 unique 제약을 없애고 8번을 마저 추가해주세요.
-- 위에서 u_address 칼럼에 걸린 제약조건의 별칭인 u_address_unique를 삭제
ALTER TABLE users DROP CONSTRAINT u_address_unique;

-- users 테이블명을 members로 바꾸겠습니다.
RENAME TABLE users to members;
SELECT * FROM members;

-- TRUNCATE TABLE은 내부 데이터만 소각합니다. 빈 테이블은 남아있습니다.
TRUNCATE TABLE members;
SELECT * FROM members;

-- DROP TABLE은 내부 데이터 및 테이블 구조 자체를 없앱니다.
DROP TABLE members;
SELECT * FROM members;
                    












