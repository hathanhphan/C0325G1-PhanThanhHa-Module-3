use student_management_ss2;

-- START: 4. Các hàm thông dụng trong SQL | [Bài tập] Luyện tập các hàm thông dụng trong SQL
-- Hiển thị tất cả các thông tin môn học (bảng subject) có credit lớn nhất.
select *
from subjects
where subject_credit >= all (select max(subject_credit) from subjects);

-- Hiển thị các thông tin môn học có điểm thi lớn nhất.
select sub.*,  max(m.mark) as max_mark
from subjects sub
join marks m on sub.subject_id = m.subject_id
group by sub.subject_id
having max_mark >= all (select max(mark) from marks);

-- Hiển thị các thông tin sinh viên và điểm trung bình của mỗi sinh viên, xếp hạng theo thứ tự điểm giảm dần
select s.*, avg(m.mark) as avg_mark
from students s
join marks m on s.student_id = m.student_id
group by m.student_id
order by avg_mark desc;
-- END: 4. Các hàm thông dụng trong SQL | [Bài tập] Luyện tập các hàm thông dụng trong SQL