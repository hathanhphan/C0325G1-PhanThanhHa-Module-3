delimiter //
create procedure all_records()
	begin
		select * from students;
    end //
delimiter ;

call all_records();
delimiter //
create procedure check_student_name(in p_student_name varchar(30))
	begin
		declare v_exists int default 0;
		select exists (select 1 from students where student_name = p_student_name) into v_exists;
		if v_exists = 1 then
			select concat('Sinh vien "', p_student_name, '" ton tai trong he thong.') as ket_qua;
		else
			select concat('Khong tim thay sinh vien ten "', p_student_name, '".') as ket_qua;
		end if;
    end //
delimiter ;
call check_student_name('Hung');