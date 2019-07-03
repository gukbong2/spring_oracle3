exec dbms_xdb.sethttpport(9090);
select dbms_xdb.gethttpport() from dual;

CREATE USER BOOK_EX IDENTIFIED BY book_ex
DEFAULT TABLESPACE USERS
TEMPORARY TABLESPACE TEMP;

GRANT CONNECT, DBA TO BOOK_EX;

CREATE SEQUENCE SEQ_BOARD;

CREATE TABLE TBL_BOARD 
(BNO NUMBER(10,0), 
TITLE VARCHAR2(200) NOT NULL,
CONTENT VARCHAR2(2000) NOT NULL,
WRITER VARCHAR2(50) NOT NULL,
REGDATE DATE DEFAULT SYSDATE,
UPDATEDATE DATE DEFAULT SYSDATE);

ALTER TABLE TBL_BOARD ADD CONSTRAINT PK_BOARD
PRIMARY KEY (BNO);

--더미 데이터

INSERT INTO TBL_BOARD (BNO, TITLE, CONTENT, WRITER)
VALUES (SEQ_BOARD.NEXTVAL, '새로 넣은 테스트 제목', '새로 넣은 테스트 내용', 'gukbong2');

select * from tbl_board order by bno desc;

SELECT * FROM TBL_BOARD WHERE TITLE = '하이요';

SELECT SEQ_BOARD.NEXTVAL FROM DUAL;

SELECT * FROM TBL_BOARD ORDER BY BNO ASC;

insert into tbl_board (bno, title, content, writer)
(select seq_board.nextval, title, content, writer from tbl_board);

select /*+INDEX_DESC(tbl_board pk_board */ * from tbl_board where bno >0;
select /*+FULL(tbl_board) */ * from tbl_board order by bno desc;

select * from (
select /*+INDEX_DESC(tbl_board pk_board) */ rownum rn, bno, title, content
from tbl_board where rownum <= 20)
where rn > 10;

CREATE TABLE TBL_REPLY
(
  RNO NUMBER(10, 0) 
, BNO NUMBER(10, 0) NOT NULL 
, REPLY VARCHAR2(1000) NOT NULL 
, REPLYER VARCHAR2(50) NOT NULL 
, REPLYDATE DATE DEFAULT SYSDATE 
, UPDATEDATE DATE DEFAULT SYSDATE
);
CREATE SEQUENCE SEQ_REPLY;

ALTER TABLE TBL_REPLY ADD CONSTRAINT PK_REPLY PRIMARY KEY (RNO);

ALTER TABLE TBL_REPLY ADD CONSTRAINT FK_REPLY_BOARD FOREIGN KEY (BNO) REFERENCES TBL_BOARD (BNO);

        select * from tbl_reply;
        
		SELECT * FROM TBL_REPLY WHERE RNO = 6;
        
        SELECT * FROM TBL_REPLY
			WHERE BNO = 2293869
				ORDER BY RNO ASC;
                
CREATE INDEX IDX_REPLY ON TBL_REPLY (BNO DESC, RNO ASC);

SELECT /*+INDEX(TBL_REPLY IDX_REPLY) */
ROWNUM RN, BNO, RNO, REPLY, REPLYER, REPLYDATE, UPDATEDATE FROM TBL_REPLY
    WHERE BNO = 2293869 AND RNO > 0;
    
SELECT * FROM 
    (SELECT /*+INDEX(TBL_REPLY IDX_REPLY) */
        ROWNUM RN, BNO, RNO, REPLY, REPLYER, REPLYDATE, UPDATEDATE FROM TBL_REPLY
            WHERE BNO = 2293869
                AND RNO > 0 AND ROWNUM <= 20)
                    WHERE RN > 10;
        

CREATE TABLE TBL_SAMPLE1 (col1 varchar2(500)); 
CREATE TABLE TBL_SAMPLE2 (col2 varchar2(50)); 



drop table tbl_sample1;
drop table tbl_sample2;

select * from tbl_sample1;
select * from tbl_sample2;

alter table tbl_board add (replycnt number default 0);

alter tablespace UNDOTBS2 add datafile 'C:/oraclexe/app/oracle/oradata/XE/UNDOTBS5.DBF' size 30m;



update tbl_board set replycnt =(select count(rno) from tbl_reply where tbl_reply.bno = tbl_board.bno);

select * from tbl_board;

alter tablespace UNDOTBS1 add datafile 'D:\Java/UNDOTBS2.DBF' size 1000m;

create table tbl_attach ( 
    uuid varchar2(100) not null,
    uploadPaath varchar2(200) not null,
    fileName varchar2(100) not null,
    fileType char(1) default 'I',
    bno number(10, 0)
    );
    
    alter table tbl_attach add constraint pk_attach primary key (uuid);
    
    alter table tbl_attach add constraint fk_board_attach foreign key (bno) references tbl_board(bno);

select * from tbl_attach where bno = 2294017;
