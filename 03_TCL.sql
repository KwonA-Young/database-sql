-- 트랜잭션은 2개 이상의 각종 쿼리문의 실행을 되돌리거나 영구히 반영할 때 사용합니다.
-- 연습 테이블 생성
CREATE TABLE bank_account(
	act_num int(5) PRIMARY KEY AUTO_INCREMENT,
    act_owner varchar(10) NOT NUll,
    balance INT(10) DEFAULT 0 NOT NULL
    );

-- 계좌 데이터 2개를 집어넣어보겠습니다.
INSERT INTO bank_account 
	VALUES (null, '나구매', 50000),
		   (null, '가판매', 0);
SELECT * FROM bank_account;

-- 트랜잭션 시작 (시작점, ROLLBACK; 수행시 이 지점 이후의 내용을 전부 취소합니다.)
START TRANSACTION;

-- 나구매의 돈 30000원 차감
UPDATE bank_account SET balance = (balance - 30000) WHERE act_owner = '나구매';
-- 가판매의 돈 30000원 증가
UPDATE bank_account SET balance = (balance + 30000) WHERE act_owner = '가판매';
set sql_safe_updates=0;
SELECT * FROM bank_account;

-- 알고보니 25000원 이어서 되돌리기
ROLLBACK;
SELECT * FROM bank_account;

-- 25000원으로 다시 차감 및 증가하는 코드를 작성해주시고, 커밋도 해주세요.
START TRANSACTION; -- 이 코드를 먼저 실행하고 요청드린 쿼리문을 작성해서 실행해주세요.

-- 나구매의 돈 25000원 차감
UPDATE bank_account SET balance = (balance - 25000) WHERE act_owner = '나구매';
-- 가판매의 돈 25000원 증가
UPDATE bank_account SET balance = (balance + 25000) WHERE act_owner = '가판매';

SELECT * FROM bank_account;
-- 34번 이후 실행한 25000원 차감 및 증가 로직 영구 반영 완료.
COMMIT;
ROLLBACK; -- 커밋한 이후에는 롤백을 실행해도 돌아갈 지점이 사라진다.

-- SAVEPOINT는 ROLLBACK 시 해당지점 전까지는 반영, 해당지점 이후는 반영하지 않는 경우 사용합니다.
START TRANSACTION;


-- 나구매의 돈 3000원 차감
UPDATE bank_account SET balance = (balance - 3000) WHERE act_owner = '나구매';
-- 가판매의 돈 3000원 증가
UPDATE bank_account SET balance = (balance + 3000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;

SAVEPOINT first_tx; -- first_tx라는 저장지점 생성

-- 나구매의 돈 5000원 차감
UPDATE bank_account SET balance = (balance - 5000) WHERE act_owner = '나구매';
-- 가판매의 돈 5000원 증가
UPDATE bank_account SET balance = (balance + 5000) WHERE act_owner = '가판매';
SELECT * FROM bank_account;
ROLLBACK to first_tx;

