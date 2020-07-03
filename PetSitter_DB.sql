create table member(
    MEMBER_ID varchar2(30) primary key, --ID
    MEMBER_NICKNAME varchar2(30) DEFAULT 'N', --�г���
    MEMBER_PW varchar2(30), --PW
    MEMBER_NAME varchar2(20), --�̸�
    MEMBER_TEL varchar2(20), --��ȭ��ȣ
    MEMBER_RANK varchar2(30) DEFAULT 'NOMAL', --���
    MEMBER_COUNT number DEFAULT 0, --Ȱ��Ƚ��
    MEMBER_AMOUNT number DEFAULT 0, --�� �ݾ�
    MEMBER_DATE date default sysdate, --���Գ�¥
    MEMBER_PHOTO varchar2(100) DEFAULT 'N', --�����ʻ���
    MEMBER_REPORT number DEFAULT 0, --�Ű�����Ƚ��
    MEMBER_GENDER varchar2(4), -- ����, �߰�
    MEMBER_ADDRESS varchar2(100) -- �ּ�, �߰�
); 
select * from member;
create table PETSITTER(
    PETSITTER_ID varchar2(30) primary key, --ID
    PETSITTER_NICKNAME varchar2(30) DEFAULT 'N', --�г���
    PETSITTER_NAME varchar2(20), --�̸�
    PETSITTER_PW varchar2(30), --PW
    PETSITTER_TEL varchar2(20), --��ȭ��ȣ
    PETSITTER_EMAIL varchar2(30), --�̸���
    PETSITTER_SCORE number(2,2) DEFAULT 0, --����
    PETSITTER_COUNT number(5) DEFAULT 0, --Ȱ��Ƚ��
    PETSITTER_RANK varchar2(20) DEFAULT 'N', --���
    PETSITTER_ADDRESS varchar2(100), --�ּ�
    PETSITTER_INTRODUCE varchar2(2000), --�ڱ�Ұ�
    PETSITTER_PRICE_12H varchar2(10), --12�ð�����
    PETSITTER_PRICE_24H varchar2(10), --24�ð�����
    PETSITTER_PRICE_30M varchar2(10), --30�а���
    PETSITTER_PRICE_60M varchar2(10), --60�а���
    PETSITTER_SERVICE_LIST varchar2(30), --������ ����
    PETSITTER_PHOTO_UPFILE varchar2(100), --���� ����
    PETSITTER_PHOTO_PROFILE_FILE varchar2(100), --������ ����
    PETSITTER_CERT_LIST varchar2(100), --�ڰ����̸�
    PETSITTER_PHOTO_CERT_FILE varchar2(300), --�ڰ��� ����
    PETSITTER_PHOTO_HOME_FILE varchar2(300), --�� ����
    PETSITTER_DATE date DEFAULT sysdate, --���� ��¥
    PETSITTER_TYPE varchar2(20), -- �ɾ�����
    PETSITTER_REPORT number(2) default 0, --�Ű�����Ƚ��, �߰�
    PETSITTER_GENDER varchar2(4) -- ����, �߰�
); 

insert into petsitter(petsitter_id, petsitter_nickname, petsitter_name, petsitter_pw, petsitter_tel, petsitter_email)
values('asd111', '�浿', 'ȫ�浿', '123123', '010-1111-2222', 'asd111@naver.com');
insert into petsitter(petsitter_id, petsitter_nickname, petsitter_name, petsitter_pw, petsitter_tel, petsitter_email)
values('asd222', '����', '�̸���', '123123', '010-2222-4444', 'asd222@naver.com');
insert into petsitter(petsitter_id, petsitter_nickname, petsitter_name, petsitter_pw, petsitter_tel, petsitter_email)
values('asd333', '��', '����', '123123', '010-3333-6666', 'asd333@naver.com');
insert into petsitter(petsitter_id, petsitter_nickname, petsitter_name, petsitter_pw, petsitter_tel, petsitter_email)
values('asd444', '��', '���', '123123', '010-4444-8888', 'asd444@naver.com');

create table NOTICE_BOARD(
    NOTICE_NUM number(10) primary key, -- �� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    NOTICE_SUBJECT varchar2(100), -- ����
    NOTICE_CONTENT varchar2(4000), -- ����
    NOTICE_PHOTO varchar2(50), -- ����
    NOTICE_READCOUNT number(6), -- ��ȸ��
    NOTICE_DATE date default sysdate -- �ۼ���
); -- ���� ����

create table REVIEW_BOARD(
    LIST_NUM number(10), -- ���� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    PETSITTER_ID varchar2(30), -- ����� ���̵�
    REVIEW_CONTENT varchar2(500), -- ���� ����
    REVIEW_SCORE number(2), -- ���� ����
    REVIEW_ORG_PHOTO varchar2(50), -- ���� ����
    REVIEW_UP_PHOTO varchar2(50), -- ���� ����
    REVIEW_READCOUNT number(6), -- ���� ��ȸ��
    REVIEW_DATE date default sysdate, -- ���� �ۼ���
    REVIEW_CHOICE varchar2(2), -- ���� ����
    LIKE_COUNT number(6) -- ���ƿ� ��
); -- ���� ����
-- ���� ���(����Ϳ�)(?)

create table PRO_BOARD(
    PRO_NUM number(6) primary key, -- �� ��ȣ
    MEMBER_ID varchar2(30), -- ���̵�
    PRO_SUBJECT varchar2(100), -- ����
    PRO_CONTENT varchar2(4000), -- ����
    PRO_ORG_FILE varchar2(100), -- �����̸�
    PRO_UP_FILE varchar2(100), -- ���ε�� �����̸�
    PRO_READCOUNT number, -- ��ȸ��
    PRO_DATE date default sysdate, -- �ۼ���
    PRO_LIKECOUNT number -- ���ƿ� ��
); -- ���� ����

create table PETSITTER_BOARD(
    PETSITTER_NUM number(10), -- ����� �Խ��� �� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    PETSITTER_ID varchar2(30), -- ����� ���̵�
    PETSITTER_SUBJECT varchar2(100), -- ����
    PETSITTER_CONTENT varchar2(4000), -- ����
    PETSITTER_DATE date default sysdate -- �ۼ���
); -- ���� ����

create table MEMBER_BOARD(
    MEMBER_NUM number(10) PRIMARY KEY, -- ȸ�� �Խ��� �� ��ȣ
    MEMBER_ID varchar2(30), -- ȸ�� ���̵�
    MEMBER_SUBJECT varchar2(100), -- ����
    MEMBER_CONTENT varchar2(4000), -- ����
    MEMBER_ORG_FILE varchar2(100), -- ���� �̸�
    MEMBER_UP_FILE varchar2(100), -- ���ε� ���� �̸�
    MEMBER_READCOUNT number, -- ��ȸ��
    MEMBER_DATE date default sysdate, -- �ۼ���
    MEMBER_LIKECOUNT number -- ���ƿ� ��
); -- ���� ����

CREATE TABLE BOARD_COMMENT (
    COMMENT_NUM NUMBER,
    COMMENT_BOARD_TYPE VARCHAR2(20),
    COMMENT_BOARD_NUM NUMBER,
    COMMENT_CONTENT VARCHAR2(500),
    COMMENT_WRITER VARCHAR2(20),
    COMMENT_DATE DATE,
    COMMENT_LIKECOUNT NUMBER
); -- ���� ����

create table USINGLIST(
    LIST_NUM number(10) primary key,
    PETSITTER_ID varchar2(30),
    MEMBER_ID varchar2(30),
    LIST_PRICE number(8),
    LIST_START_DATE date,
    LIST_END_DATE date,
    LIST_TYPE varchar2(10)
);

-- usinglist ���� ������
insert into usinglist
values('5', 'asd111', 'asdasd@naver.com', '30000', '2020/06/29', '2020/06/30', '��Ź');
insert into usinglist
values('7', 'asd222', 'asdasd@naver.com', '60000', '2020/06/30', '2020/07/01', '��Ź');
insert into usinglist
values('6', 'asd111', 'asdasd@naver.com', '20000', '2020/06/29', '2020/06/29', '�湮');
insert into usinglist
values('4', 'asd333', 'asdasd@naver.com', '40000', '2020/06/27', '2020/06/28', '��Ź');
insert into usinglist
values('3', 'asd444', 'asdasd@naver.com', '80000', '2020/06/25', '2020/06/26', '��Ź');
insert into usinglist
values('8', 'asd333', 'asdasd@naver.com', '80000', '2020/07/01', '2020/07/02', '��Ź');
insert into usinglist
values('9', 'asd111', 'asdasd@naver.com', '70000', '2020/07/02', '2020/07/03', '��Ź');
insert into usinglist
values('2', 'asd111', 'asdasd@naver.com', '70000', '2020/05/21', '2020/05/22', '��Ź');
insert into usinglist
values('1', 'asd222', 'asdasd@naver.com', '90000', '2020/02/21', '2020/02/22', '��Ź');
insert into usinglist
values('10', 'asd333', 'asdasd@naver.com', '120000', '2020/07/02', '2020/07/05', '��Ź');

select * from usinglist where member_id='asdasd@naver.com' order by list_num desc;
select * from petsitter where petsitter_id='asd444';
commit;

select list_num, member_id, list_price, list_start_date, list_end_date, list_type, petsitter_nickname, petsitter_name, petsitter_tel 
from usinglist u, petsitter p 
where member_id='asdasd@naver.com' and u.petsitter_id = p.petsitter_id order by list_num desc;

select u.list_num, u.member_id, u.list_price, u.list_start_date, u.list_end_date, u.list_type, p.petsitter_nickname, p.petsitter_name, p.petsitter_tel 
from usinglist u, petsitter p 
where member_id='asdasd@naver.com' and u.petsitter_id = p.petsitter_id and u.list_start_date >= trunc(add_months(sysdate,-1))
order by list_num desc;

select * from usinglist 
where MEMBER_ID='asdasd@naver.com' and list_start_date >= trunc(add_months(sysdate, -1)) 
order by LIST_NUM desc;

select * from usinglist 
where MEMBER_ID='asdasd@naver.com'
order by LIST_NUM desc;

select * from usinglist
where MEMBER_ID='asdasd@naver.com' and 
      (list_start_date between to_date('2020-07-03', 'YYYY-MM-DD') and to_date('2020-07-05', 'YYYY-MM-DD') or
      list_end_date between to_date('2020-07-03', 'YYYY-MM-DD') and to_date('2020-07-05', 'YYYY-MM-DD'));
      
select list_num, member_id, list_price, list_start_date, list_end_date, list_type, petsitter_nickname, petsitter_name, petsitter_tel 
from usinglist , petsitter 
where MEMBER_ID='asdasd@naver.com' and usinglist.PETSITTER_ID=petsitter.PETSITTER_ID and 
      (list_start_date between to_date('2020-07-03', 'YYYY-MM-DD') and to_date('2020-07-04', 'YYYY-MM-DD') or
      list_end_date between to_date('2020-07-03', 'YYYY-MM-DD') and to_date('2020-07-04', 'YYYY-MM-DD'))
order by LIST_NUM desc;