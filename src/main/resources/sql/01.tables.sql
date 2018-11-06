DROP TABLE IF EXISTS TB_ISSUE_FILE;

DROP TABLE IF EXISTS TB_ISSUE_HISTORY;

DROP TABLE IF EXISTS TB_ISSUE_LIKE;

DROP TABLE IF EXISTS TB_ISSUE_RELATION;

DROP TABLE IF EXISTS TB_OPINION_LIKE;

DROP TABLE IF EXISTS TB_OPINION;

DROP TABLE IF EXISTS TB_ISSUE;

DROP TABLE IF EXISTS TB_ISSUE_CATEGORY;

DROP TABLE IF EXISTS TB_ISSUE_STATS;

DROP TABLE IF EXISTS TB_POST;

DROP TABLE IF EXISTS TB_USER_LOGIN;

DROP TABLE IF EXISTS TB_USER;

-- 회원
CREATE TABLE `TB_USER` (
	`USER_ID`     BIGINT(20) UNSIGNED NOT NULL COMMENT '회원ID', -- 회원ID
	`REG_DT`      DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시', -- 등록일시
	`REG_IP`      VARCHAR(15)         NOT NULL COMMENT '등록아이피', -- 등록아이피
	`USER_EMAIL`  VARCHAR(100)        NOT NULL COMMENT '회원이메일', -- 회원이메일
	`USER_ROLE`   VARCHAR(12)         NOT NULL COMMENT '회원권한', -- 회원권한
	`USER_STATUS` VARCHAR(12)         NOT NULL COMMENT '회원상태', -- 회원상태
	`USER_NAME`   VARCHAR(100)        NOT NULL COMMENT '회원이름', -- 회원이름
	`USER_PASSWD` VARCHAR(64)         NOT NULL COMMENT '회원비밀번호', -- 회원비밀번호
	`LOGIN_DT`    DATETIME            NULL     COMMENT '로그인일시', -- 로그인일시
	`LOGIN_IP`    VARCHAR(15)         NULL     COMMENT '로그인아이피', -- 로그인아이피
	`USER_TOKEN`  CHAR(32)            NULL     COMMENT '회원토큰', -- 회원토큰
	`IMG_URL`     VARCHAR(300)        NULL     COMMENT '이미지URL', -- 이미지URL
	`DEPART1`     VARCHAR(100)        NULL     COMMENT '부서1', -- 부서1
	`DEPART2`     VARCHAR(100)        NULL     COMMENT '부서2', -- 부서2
	`DEPART3`     VARCHAR(100)        NULL     COMMENT '부서3' -- 부서3
)
COMMENT '회원';

-- 회원
ALTER TABLE `TB_USER`
	ADD CONSTRAINT `PK_TB_USER` -- 회원 Primary key
		PRIMARY KEY (
			`USER_ID` -- 회원ID
		);

-- 회원 Unique Index
CREATE UNIQUE INDEX `UIX_TB_USER`
	ON `TB_USER` ( -- 회원
		`USER_EMAIL` ASC -- 회원이메일
	);

-- 회원 Index
CREATE INDEX `IX_TB_USER`
	ON `TB_USER`( -- 회원
		`USER_ROLE` ASC -- 회원권한
	);

ALTER TABLE `TB_USER`
	MODIFY COLUMN `USER_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '회원ID';

-- 회원로그인
CREATE TABLE `TB_USER_LOGIN` (
	`LOGIN_ID` BIGINT(20) UNSIGNED NOT NULL COMMENT '로그인ID', -- 로그인ID
	`USER_ID`  BIGINT(20) UNSIGNED NOT NULL COMMENT '회원ID', -- 회원ID
	`REG_DT`   DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시', -- 등록일시
	`REG_IP`   VARCHAR(15)         NOT NULL COMMENT '등록아이피' -- 등록아이피
)
COMMENT '회원로그인';

-- 회원로그인
ALTER TABLE `TB_USER_LOGIN`
	ADD CONSTRAINT `PK_TB_USER_LOGIN` -- 회원로그인 Primary key
		PRIMARY KEY (
			`LOGIN_ID` -- 로그인ID
		);

ALTER TABLE `TB_USER_LOGIN`
	MODIFY COLUMN `LOGIN_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '로그인ID';

-- 이슈
CREATE TABLE `TB_ISSUE` (
	`ISSUE_ID`           BIGINT(20) UNSIGNED NOT NULL COMMENT '이슈ID', -- 이슈ID
	`ISSUE_DTYPE`        CHAR(1)             NOT NULL COMMENT '이슈종류', -- 이슈종류
	`REG_DT`             DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP
	 COMMENT '등록일시', -- 등록일시
	`CHG_DT`             DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시', -- 수정일시
	`REG_ID`             BIGINT(20) UNSIGNED NOT NULL COMMENT '등록ID', -- 등록ID
	`CHG_ID`             BIGINT(20) UNSIGNED NOT NULL COMMENT '수정ID', -- 수정ID
	`REG_IP`             VARCHAR(15)         NOT NULL COMMENT '등록아이피', -- 등록아이피
	`CHG_IP`             VARCHAR(15)         NOT NULL COMMENT '수정아이피', -- 수정아이피
	`CATE_ID`            BIGINT(20) UNSIGNED NOT NULL COMMENT '범주ID', -- 범주ID
	`STATS_ID`           BIGINT(20) UNSIGNED NOT NULL COMMENT '통계ID', -- 통계ID
	`ISSUE_STATUS`       VARCHAR(12)         NOT NULL COMMENT '이슈상태', -- 이슈상태
	`ISSUE_PROCESS`      VARCHAR(12)         NOT NULL COMMENT '이슈과정', -- 이슈과정
	`OPINION_TYPE`       VARCHAR(12)         NOT NULL COMMENT '의견타입', -- 의견타입
	`ISSUE_TITLE`        VARCHAR(300)        NOT NULL COMMENT '이슈제목', -- 이슈제목
	`ISSUE_CONTENT`      LONGTEXT            NULL     COMMENT '이슈내용', -- 이슈내용
	`IMG_URL`            VARCHAR(300)        NULL     COMMENT '이미지URL', -- 이미지URL
	`DEBATE_STDATE`      DATE                NULL     COMMENT '토론시작일', -- 토론시작일
	`DEBATE_EDDATE`      DATE                NULL     COMMENT '토론종료일', -- 토론종료일
	`ADMIN_COMMENT_DT`   DATETIME            NULL     COMMENT '관리자댓글일시', -- 관리자댓글일시
	`ADMIN_COMMENT`      LONGTEXT            NULL     COMMENT '관리자댓글', -- 관리자댓글
	`MANAGER_ID`         BIGINT(20) UNSIGNED NULL     COMMENT '매니저ID', -- 매니저ID
	`MANAGER_COMMENT_DT` DATETIME            NULL     COMMENT '매니저댓글일시', -- 매니저댓글일시
	`MANAGER_COMMENT`    LONGTEXT            NULL     COMMENT '매니저댓글' -- 매니저댓글
)
COMMENT '이슈';

-- 이슈
ALTER TABLE `TB_ISSUE`
	ADD CONSTRAINT `PK_TB_ISSUE` -- 이슈 Primary key
		PRIMARY KEY (
			`ISSUE_ID` -- 이슈ID
		);

ALTER TABLE `TB_ISSUE`
	MODIFY COLUMN `ISSUE_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '이슈ID';

-- 이슈범주
CREATE TABLE `TB_ISSUE_CATEGORY` (
	`CATE_ID`   BIGINT(20) UNSIGNED NOT NULL COMMENT '범주ID', -- 범주ID
	`CATE_NAME` VARCHAR(100)        NOT NULL COMMENT '범주이름', -- 범주이름
	`USE_YN`    BOOLEAN             NOT NULL COMMENT '사용여부', -- 사용여부
	`CATE_SEQ`  INT(11) UNSIGNED    NOT NULL DEFAULT 0 COMMENT '범주순번' -- 범주순번
)
COMMENT '이슈범주';

-- 이슈범주
ALTER TABLE `TB_ISSUE_CATEGORY`
	ADD CONSTRAINT `PK_TB_ISSUE_CATEGORY` -- 이슈범주 Primary key
		PRIMARY KEY (
			`CATE_ID` -- 범주ID
		);

-- 이슈범주 Unique Index
CREATE UNIQUE INDEX `UIX_TB_ISSUE_CATEGORY`
	ON `TB_ISSUE_CATEGORY` ( -- 이슈범주
		`CATE_NAME` ASC -- 범주이름
	);

ALTER TABLE `TB_ISSUE_CATEGORY`
	MODIFY COLUMN `CATE_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '범주ID';

-- 이슈통계
CREATE TABLE `TB_ISSUE_STATS` (
	`STATS_ID`      BIGINT(20) UNSIGNED NOT NULL COMMENT '통계ID', -- 통계ID
	`VIEW_CNT`      BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '조회수', -- 조회수
	`LIKE_CNT`      BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '좋아요수', -- 좋아요수
	`APPLICANT_CNT` BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '참여자수', -- 참여자수
	`YES_CNT`       BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '찬성수', -- 찬성수
	`NO_CNT`        BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '반대수', -- 반대수
	`ETC_CNT`       BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '기타수' -- 기타수
)
COMMENT '이슈통계';

-- 이슈통계
ALTER TABLE `TB_ISSUE_STATS`
	ADD CONSTRAINT `PK_TB_ISSUE_STATS` -- 이슈통계 Primary key
		PRIMARY KEY (
			`STATS_ID` -- 통계ID
		);

ALTER TABLE `TB_ISSUE_STATS`
	MODIFY COLUMN `STATS_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '통계ID';

-- 의견
CREATE TABLE `TB_OPINION` (
	`OPINION_ID`      BIGINT(20) UNSIGNED NOT NULL COMMENT '의견ID', -- 의견ID
	`OPINION_DTYPE`   CHAR(1)             NOT NULL COMMENT '의견종류', -- 의견종류
	`REG_DT`          DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP
	 COMMENT '등록일시', -- 등록일시
	`CHG_DT`          DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시', -- 수정일시
	`REG_ID`          BIGINT(20) UNSIGNED NOT NULL COMMENT '등록ID', -- 등록ID
	`CHG_ID`          BIGINT(20) UNSIGNED NOT NULL COMMENT '수정ID', -- 수정ID
	`REG_IP`          VARCHAR(15)         NOT NULL COMMENT '등록아이피', -- 등록아이피
	`CHG_IP`          VARCHAR(15)         NOT NULL COMMENT '수정아이피', -- 수정아이피
	`ISSUE_ID`        BIGINT(20) UNSIGNED NOT NULL COMMENT '이슈ID', -- 이슈ID
	`LIKE_CNT`        BIGINT(20) UNSIGNED NOT NULL DEFAULT 0 COMMENT '좋아요수', -- 좋아요수
	`OPINION_STATUS`  VARCHAR(12)         NOT NULL COMMENT '의견상태', -- 의견상태
	`OPINION_VOTE`    VARCHAR(12)         NOT NULL COMMENT '의견투표', -- 의견투표
	`OPINION_CONTENT` VARCHAR(3000)       NOT NULL COMMENT '의견내용' -- 의견내용
)
COMMENT '의견';

-- 의견
ALTER TABLE `TB_OPINION`
	ADD CONSTRAINT `PK_TB_OPINION` -- 의견 Primary key
		PRIMARY KEY (
			`OPINION_ID` -- 의견ID
		);

ALTER TABLE `TB_OPINION`
	MODIFY COLUMN `OPINION_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '의견ID';

-- 이슈좋아요
CREATE TABLE `TB_ISSUE_LIKE` (
	`USER_ID`  BIGINT(20) UNSIGNED NOT NULL COMMENT '회원ID', -- 회원ID
	`ISSUE_ID` BIGINT(20) UNSIGNED NOT NULL COMMENT '이슈ID', -- 이슈ID
	`REG_DT`   DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '등록일시', -- 등록일시
	`REG_IP`   VARCHAR(15)         NOT NULL COMMENT '등록아이피' -- 등록아이피
)
COMMENT '이슈좋아요';

-- 이슈좋아요
ALTER TABLE `TB_ISSUE_LIKE`
	ADD CONSTRAINT `PK_TB_ISSUE_LIKE` -- 이슈좋아요 Primary key
		PRIMARY KEY (
			`USER_ID`,  -- 회원ID
			`ISSUE_ID`  -- 이슈ID
		);

-- 의견좋아요
CREATE TABLE `TB_OPINION_LIKE` (
	`USER_ID`    BIGINT(20) UNSIGNED NOT NULL COMMENT '회원ID', -- 회원ID
	`OPINION_ID` BIGINT(20) UNSIGNED NOT NULL COMMENT '의견ID', -- 의견ID
	`REG_DT`     DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP
	 COMMENT '등록일시', -- 등록일시
	`REG_IP`     VARCHAR(15)         NOT NULL COMMENT '등록아이피' -- 등록아이피
)
COMMENT '의견좋아요';

-- 의견좋아요
ALTER TABLE `TB_OPINION_LIKE`
	ADD CONSTRAINT `PK_TB_OPINION_LIKE` -- 의견좋아요 Primary key
		PRIMARY KEY (
			`USER_ID`,    -- 회원ID
			`OPINION_ID`  -- 의견ID
		);

-- 이슈파일
CREATE TABLE `TB_ISSUE_FILE` (
	`ISSUE_ID`  BIGINT(20) UNSIGNED NOT NULL COMMENT '이슈ID', -- 이슈ID
	`FILE_SEQ`  INT(11) UNSIGNED    NOT NULL COMMENT '파일순번', -- 파일순번
	`FILE_NAME` VARCHAR(300)        NOT NULL COMMENT '파일이름', -- 파일이름
	`FILE_URL`  VARCHAR(300)        NOT NULL COMMENT '파일URL' -- 파일URL
)
COMMENT '이슈파일';

-- 이슈파일
ALTER TABLE `TB_ISSUE_FILE`
	ADD CONSTRAINT `PK_TB_ISSUE_FILE` -- 이슈파일 Primary key
		PRIMARY KEY (
			`ISSUE_ID`, -- 이슈ID
			`FILE_SEQ`  -- 파일순번
		);

-- 이슈연관
CREATE TABLE `TB_ISSUE_RELATION` (
	`ISSUE_ID`     BIGINT(20) UNSIGNED NOT NULL COMMENT '이슈ID', -- 이슈ID
	`RELATION_SEQ` INT(11) UNSIGNED    NOT NULL COMMENT '연관순번', -- 연관순번
	`RELATION_ID`  BIGINT(20) UNSIGNED NOT NULL COMMENT '연관ID' -- 연관ID
)
COMMENT '이슈연관';

-- 이슈연관
ALTER TABLE `TB_ISSUE_RELATION`
	ADD CONSTRAINT `PK_TB_ISSUE_RELATION` -- 이슈연관 Primary key
		PRIMARY KEY (
			`ISSUE_ID`,     -- 이슈ID
			`RELATION_SEQ`  -- 연관순번
		);

-- 글
CREATE TABLE `TB_POST` (
	`POST_ID`      BIGINT(20) UNSIGNED NOT NULL COMMENT '글ID', -- 글ID
	`REG_DT`       DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP
	 COMMENT '등록일시', -- 등록일시
	`CHG_DT`       DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시', -- 수정일시
	`REG_ID`       BIGINT(20) UNSIGNED NOT NULL COMMENT '등록ID', -- 등록ID
	`CHG_ID`       BIGINT(20) UNSIGNED NOT NULL COMMENT '수정ID', -- 수정ID
	`REG_IP`       VARCHAR(15)         NOT NULL COMMENT '등록아이피', -- 등록아이피
	`CHG_IP`       VARCHAR(15)         NOT NULL COMMENT '수정아이피', -- 수정아이피
	`POST_TYPE`    VARCHAR(12)         NOT NULL COMMENT '글타입', -- 글타입
	`POST_STATUS`  VARCHAR(12)         NOT NULL COMMENT '글상태', -- 글상태
	`POST_TITLE`   VARCHAR(300)        NOT NULL COMMENT '글제목', -- 글제목
	`POST_CONTENT` LONGTEXT            NOT NULL COMMENT '글내용' -- 글내용
)
COMMENT '글';

-- 글
ALTER TABLE `TB_POST`
	ADD CONSTRAINT `PK_TB_POST` -- 글 Primary key
		PRIMARY KEY (
			`POST_ID` -- 글ID
		);

ALTER TABLE `TB_POST`
	MODIFY COLUMN `POST_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '글ID';

-- 이슈히스토리
CREATE TABLE `TB_ISSUE_HISTORY` (
	`HISTORY_ID`      BIGINT(20) UNSIGNED NOT NULL COMMENT '히스토리ID', -- 히스토리ID
	`ISSUE_ID`        BIGINT(20) UNSIGNED NOT NULL COMMENT '이슈ID', -- 이슈ID
	`REG_DT`          DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP
	 COMMENT '등록일시', -- 등록일시
	`CHG_DT`          DATETIME            NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '수정일시', -- 수정일시
	`REG_ID`          BIGINT(20) UNSIGNED NOT NULL COMMENT '등록ID', -- 등록ID
	`CHG_ID`          BIGINT(20) UNSIGNED NOT NULL COMMENT '수정ID', -- 수정ID
	`REG_IP`          VARCHAR(15)         NOT NULL COMMENT '등록아이피', -- 등록아이피
	`CHG_IP`          VARCHAR(15)         NOT NULL COMMENT '수정아이피', -- 수정아이피
	`HISTORY_STATUS`  VARCHAR(12)         NOT NULL COMMENT '히스토리상태', -- 히스토리상태
	`HISTORY_CONTENT` LONGTEXT            NOT NULL COMMENT '히스토리내용' -- 히스토리내용
)
COMMENT '이슈히스토리';

-- 이슈히스토리
ALTER TABLE `TB_ISSUE_HISTORY`
	ADD CONSTRAINT `PK_TB_ISSUE_HISTORY` -- 이슈히스토리 Primary key
		PRIMARY KEY (
			`HISTORY_ID` -- 히스토리ID
		);

ALTER TABLE `TB_ISSUE_HISTORY`
	MODIFY COLUMN `HISTORY_ID` BIGINT(20) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '히스토리ID';

-- 이슈
ALTER TABLE `TB_ISSUE`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_ISSUE` -- 회원 -> 이슈
		FOREIGN KEY (
			`REG_ID` -- 등록ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		),
	ADD INDEX `FK_TB_USER_TO_TB_ISSUE` (
		`REG_ID` ASC -- 등록ID
	);

-- 이슈
ALTER TABLE `TB_ISSUE`
	ADD CONSTRAINT `FK_TB_ISSUE_CATEGORY_TO_TB_ISSUE` -- 이슈범주 -> 이슈
		FOREIGN KEY (
			`CATE_ID` -- 범주ID
		)
		REFERENCES `TB_ISSUE_CATEGORY` ( -- 이슈범주
			`CATE_ID` -- 범주ID
		),
	ADD INDEX `FK_TB_ISSUE_CATEGORY_TO_TB_ISSUE` (
		`CATE_ID` ASC -- 범주ID
	);

-- 이슈
ALTER TABLE `TB_ISSUE`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_ISSUE3` -- 회원 -> 이슈3
		FOREIGN KEY (
			`MANAGER_ID` -- 매니저ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		),
	ADD INDEX `FK_TB_USER_TO_TB_ISSUE3` (
		`MANAGER_ID` ASC -- 매니저ID
	);

-- 의견
ALTER TABLE `TB_OPINION`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_OPINION` -- 회원 -> 의견
		FOREIGN KEY (
			`REG_ID` -- 등록ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		),
	ADD INDEX `FK_TB_USER_TO_TB_OPINION` (
		`REG_ID` ASC -- 등록ID
	);

-- 의견
ALTER TABLE `TB_OPINION`
	ADD CONSTRAINT `FK_TB_ISSUE_TO_TB_OPINION` -- 이슈 -> 의견
		FOREIGN KEY (
			`ISSUE_ID` -- 이슈ID
		)
		REFERENCES `TB_ISSUE` ( -- 이슈
			`ISSUE_ID` -- 이슈ID
		),
	ADD INDEX `FK_TB_ISSUE_TO_TB_OPINION` (
		`ISSUE_ID` ASC -- 이슈ID
	);

-- 이슈좋아요
ALTER TABLE `TB_ISSUE_LIKE`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_ISSUE_LIKE` -- 회원 -> 이슈좋아요
		FOREIGN KEY (
			`USER_ID` -- 회원ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		),
	ADD INDEX `FK_TB_USER_TO_TB_ISSUE_LIKE` (
		`USER_ID` ASC -- 회원ID
	);

-- 이슈좋아요
ALTER TABLE `TB_ISSUE_LIKE`
	ADD CONSTRAINT `FK_TB_ISSUE_TO_TB_ISSUE_LIKE` -- 이슈 -> 이슈좋아요
		FOREIGN KEY (
			`ISSUE_ID` -- 이슈ID
		)
		REFERENCES `TB_ISSUE` ( -- 이슈
			`ISSUE_ID` -- 이슈ID
		),
	ADD INDEX `FK_TB_ISSUE_TO_TB_ISSUE_LIKE` (
		`ISSUE_ID` ASC -- 이슈ID
	);

-- 의견좋아요
ALTER TABLE `TB_OPINION_LIKE`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_OPINION_LIKE` -- 회원 -> 의견좋아요
		FOREIGN KEY (
			`USER_ID` -- 회원ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		),
	ADD INDEX `FK_TB_USER_TO_TB_OPINION_LIKE` (
		`USER_ID` ASC -- 회원ID
	);

-- 의견좋아요
ALTER TABLE `TB_OPINION_LIKE`
	ADD CONSTRAINT `FK_TB_OPINION_TO_TB_OPINION_LIKE` -- 의견 -> 의견좋아요
		FOREIGN KEY (
			`OPINION_ID` -- 의견ID
		)
		REFERENCES `TB_OPINION` ( -- 의견
			`OPINION_ID` -- 의견ID
		),
	ADD INDEX `FK_TB_OPINION_TO_TB_OPINION_LIKE` (
		`OPINION_ID` ASC -- 의견ID
	);

-- 이슈파일
ALTER TABLE `TB_ISSUE_FILE`
	ADD CONSTRAINT `FK_TB_ISSUE_TO_TB_ISSUE_FILE` -- 이슈 -> 이슈파일
		FOREIGN KEY (
			`ISSUE_ID` -- 이슈ID
		)
		REFERENCES `TB_ISSUE` ( -- 이슈
			`ISSUE_ID` -- 이슈ID
		),
	ADD INDEX `FK_TB_ISSUE_TO_TB_ISSUE_FILE` (
		`ISSUE_ID` ASC -- 이슈ID
	);

-- 이슈연관
ALTER TABLE `TB_ISSUE_RELATION`
	ADD CONSTRAINT `FK_TB_ISSUE_TO_TB_ISSUE_RELATION` -- 이슈 -> 이슈연관
		FOREIGN KEY (
			`ISSUE_ID` -- 이슈ID
		)
		REFERENCES `TB_ISSUE` ( -- 이슈
			`ISSUE_ID` -- 이슈ID
		),
	ADD INDEX `FK_TB_ISSUE_TO_TB_ISSUE_RELATION` (
		`ISSUE_ID` ASC -- 이슈ID
	);

-- 이슈히스토리
ALTER TABLE `TB_ISSUE_HISTORY`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_ISSUE_HISTORY` -- 회원 -> 이슈히스토리
		FOREIGN KEY (
			`REG_ID` -- 등록ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		),
	ADD INDEX `FK_TB_USER_TO_TB_ISSUE_HISTORY` (
		`REG_ID` ASC -- 등록ID
	);

-- 이슈히스토리
ALTER TABLE `TB_ISSUE_HISTORY`
	ADD CONSTRAINT `FK_TB_ISSUE_TO_TB_ISSUE_HISTORY` -- 이슈 -> 이슈히스토리
		FOREIGN KEY (
			`ISSUE_ID` -- 이슈ID
		)
		REFERENCES `TB_ISSUE` ( -- 이슈
			`ISSUE_ID` -- 이슈ID
		),
	ADD INDEX `FK_TB_ISSUE_TO_TB_ISSUE_HISTORY` (
		`ISSUE_ID` ASC -- 이슈ID
	);

-- 회원로그인
ALTER TABLE `TB_USER_LOGIN`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_USER_LOGIN` -- 회원 -> 회원로그인
		FOREIGN KEY (
			`USER_ID` -- 회원ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		);

-- 이슈
ALTER TABLE `TB_ISSUE`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_ISSUE2` -- 회원 -> 이슈2
		FOREIGN KEY (
			`CHG_ID` -- 수정ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		);

-- 이슈
ALTER TABLE `TB_ISSUE`
	ADD CONSTRAINT `FK_TB_ISSUE_STATS_TO_TB_ISSUE` -- 이슈통계 -> 이슈
		FOREIGN KEY (
			`STATS_ID` -- 통계ID
		)
		REFERENCES `TB_ISSUE_STATS` ( -- 이슈통계
			`STATS_ID` -- 통계ID
		);

-- 의견
ALTER TABLE `TB_OPINION`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_OPINION2` -- 회원 -> 의견2
		FOREIGN KEY (
			`CHG_ID` -- 수정ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		);

-- 이슈연관
ALTER TABLE `TB_ISSUE_RELATION`
	ADD CONSTRAINT `FK_TB_ISSUE_TO_TB_ISSUE_RELATION2` -- 이슈 -> 이슈연관2
		FOREIGN KEY (
			`RELATION_ID` -- 연관ID
		)
		REFERENCES `TB_ISSUE` ( -- 이슈
			`ISSUE_ID` -- 이슈ID
		);

-- 글
ALTER TABLE `TB_POST`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_POST` -- 회원 -> 글
		FOREIGN KEY (
			`REG_ID` -- 등록ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		);

-- 글
ALTER TABLE `TB_POST`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_POST2` -- 회원 -> 글2
		FOREIGN KEY (
			`CHG_ID` -- 수정ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		);

-- 이슈히스토리
ALTER TABLE `TB_ISSUE_HISTORY`
	ADD CONSTRAINT `FK_TB_USER_TO_TB_ISSUE_HISTORY2` -- 회원 -> 이슈히스토리2
		FOREIGN KEY (
			`CHG_ID` -- 수정ID
		)
		REFERENCES `TB_USER` ( -- 회원
			`USER_ID` -- 회원ID
		);