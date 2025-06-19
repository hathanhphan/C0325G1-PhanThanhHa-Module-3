use student_management_ss2;

-- START: 4. Các hàm thông dụng trong SQL | [Thực hành] Sử dụng các hàm thông dụng trong SQL (v.2023)
-- Hiển thị số lượng sinh viên ở từng nơi
select student_address, count(student_id) as student_count
from students group by student_address;

-- Tính điểm trung bình các môn học của mỗi học viên
select s.student_id, s.student_name, sub.subject_name, avg(m.mark) as avg_mark
from students s
join marks m on s.student_id = m.student_id
join subjects sub on m.subject_id = sub.subject_id
group by m.student_id, m.subject_id;

-- Hiển thị những bạn học viên co điểm trung bình các môn học lớn hơn 15
select s.student_id, s.student_name, avg(m.mark) as avg_mark
from students s
join marks m on s.student_id = m.student_id
group by m.student_id, m.subject_id
having avg_mark > 15;

-- Hiển thị thông tin các học viên có điểm trung bình lớn nhất.
select s.student_id, s.student_name, avg(m.mark) as avg_mark
from students s
join marks m on s.student_id = m.student_id
group by m.student_id
having avg_mark >= all (select avg(mark) from marks group by student_id);
-- END: 4. Các hàm thông dụng trong SQL | [Thực hành] Sử dụng các hàm thông dụng trong SQL (v.2023)
 