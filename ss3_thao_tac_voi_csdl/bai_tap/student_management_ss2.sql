-- START: 2. Thiết kế và tạo CSDL | [Thực hành] Tạo CSDL quản lý sinh viên (v.2023)
create database student_management_ss2;

use student_management_ss2;

create table classes (
	class_id int auto_increment,
    class_name varchar(60) not null,
    class_start_date datetime not null,
    class_status bit(1),
    primary key (class_id)
);

create table students (
	student_id int auto_increment,
    student_name varchar(30) not null,
    student_address varchar(50),
    student_phone varchar(20),
    student_status bit(1),
    class_id int not null,
    primary key (student_id),
    foreign key (class_id) references classes (class_id)
);

create table subjects (
	subject_id int auto_increment,
    subject_name varchar(30) not null,
    subject_credit tinyint not null 
		default 1
        check (subject_credit >= 1),
	subject_status bit(1) default 1,
    primary key (subject_id)
);

create table marks (
	mark_id int auto_increment,
    subject_id int not null,
    student_id int not null,
    mark float default 0
		check (mark between 0 and 100),
	exam_times tinyint default 1,
    unique (subject_id, student_id),
    primary key (mark_id),
    foreign key (subject_id) references subjects (subject_id),
    foreign key (student_id) references students (student_id)
);
-- END: 2. Thiết kế và tạo CSDL | [Thực hành] Tạo CSDL quản lý sinh viên (v.2023)

-- START: 3. Thao tác với CSDL | [Thực hành] Thêm dữ liệu vào trong cơ sở dữ liệu quản lý sinh viên (v.2023)
insert into classes (class_name, class_start_date, class_status) values
('A1', '2008-12-20', 1),
('A2', '2008-12-22', 1),
('B3', current_date(), 0);

insert into students (student_name, student_address, student_phone, student_status, class_id) values
('Hung', 'Ha Noi', '0912113113', 1, 1),
('Hoa', 'Hai phong', null, 1, 1),
('Manh', 'HCM', '0123123123', 0, 2);

insert into subjects (subject_name, subject_credit, subject_status) values
('CF', 5, 1),
('C', 6, 1),
('HDJ', 5, 1),
('RDBMS', 10, 1);

insert into marks (subject_id, student_id, mark, exam_times) values
(1, 1, 8, 1),
(1, 2, 10, 2),
(2, 1, 12, 1);
-- END: 3. Thao tác với CSDL | [Thực hành] Thêm dữ liệu vào trong cơ sở dữ liệu quản lý sinh viên (v.2023)

-- START: 3. Thao tác với CSDL | [Thực hành] Truy vấn dữ liệu với CSDL Quản lý sinh viên (v.2023)
-- Hiển thị danh sách tất cả các học viên.
select * from students;

-- Hiển thị danh sách các học viên đang theo học.
select * from students where student_status = 1;

-- Hiển thị danh sách các môn học có thời gian học nhỏ hơn 10 giờ.
select * from subjects where subject_credit < 10;

-- Hiển thị danh sách học viên lớp A1.
select s.student_id, s.student_name, s.student_address, s.student_phone, c.class_name
from students s
join classes c on s.class_id = c.class_id
where c.class_name = 'A1';

-- Hiển thị điểm môn CF của các học viên.
select s.student_id, s.student_name, sub.subject_name, m.mark
from students s
join marks m on s.student_id = m.student_id
join subjects sub on m.subject_id = sub.subject_id
where sub.subject_name = 'CF';
-- END: 3. Thao tác với CSDL | [Thực hành] Truy vấn dữ liệu với CSDL Quản lý sinh viên (v.2023)

-- START: 3. Thao tác với CSDL | [Bài tập] Truy vấn dữ liệu với CSDL Quản lý sinh viên
-- Hiển thị tất cả các sinh viên có tên bắt đầu bảng ký tự ‘h’
select * from students where student_name like 'h%';

-- Hiển thị các thông tin lớp học có thời gian bắt đầu vào tháng 12.
select * from classes where month(class_start_date) = 12;

-- Hiển thị tất cả các thông tin môn học có credit trong khoảng từ 3-5.
select * from subjects where subject_credit between 3 and 5;

-- Thay đổi mã lớp (ClassID) của sinh viên có tên ‘Hung’ là 2.
set SQL_SAFE_UPDATES = 0;
update students
set class_id = 2
where student_name = 'Hung';
set SQL_SAFE_UPDATES = 1;

-- Hiển thị các thông tin: StudentName, SubName, Mark. Dữ liệu sắp xếp theo điểm thi (mark) giảm dần. nếu trùng sắp theo tên tăng dần.
select s.student_name, sub.subject_name, m.mark
from students s
join marks m on s.student_id = m.student_id
join subjects sub on m.subject_id = sub.subject_id
order by m.mark desc, s.student_name asc;
-- END: 3. Thao tác với CSDL | [Bài tập] Truy vấn dữ liệu với CSDL Quản lý sinh viên