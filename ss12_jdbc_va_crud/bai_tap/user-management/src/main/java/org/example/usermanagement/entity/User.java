package org.example.usermanagement.entity;

import javax.validation.constraints.*;

public class User {
    private Integer id;

    @NotBlank(message = "Tên người dùng không được để trống")
    @Size(min = 2, max = 100, message = "Tên người dùng phải từ {min} đến {max} ký tự")
    private String name;

    @NotBlank(message = "Email không được để trống")
    @Email(message = "Cần nhập đúng định dạng email (ví dụ abc@example.com)")
    private String email;

    @NotBlank(message = "Quốc gia không được để trống")
    @Size(min = 2, max = 100, message = "Quốc gia phải từ {min} đến {max} ký tự")
    private String country;

    public User() {
    }

    public User(Integer id, String name, String email, String country) {
        this.id = id;
        this.name = name;
        this.email = email;
        this.country = country;
    }

    public User(String name, String email, String country) {
        this.name = name;
        this.email = email;
        this.country = country;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
}
