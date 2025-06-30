package org.example.displaycustomerlist.entity;

import java.time.LocalDate;

public class Customer {
    private Integer id;
    private String name;
    private LocalDate dob;
    private String address;
    private String avatarUrl;

    public Customer(Integer id, String name, LocalDate dob, String address, String avatarUrl) {
        this.id = id;
        this.name = name;
        this.dob = dob;
        this.address = address;
        this.avatarUrl = avatarUrl;
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

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }
}
