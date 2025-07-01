package org.example.usermanagement.service;

import org.example.usermanagement.entity.User;

import java.util.List;

public interface UserService extends IService<User> {
    List<User> searchByCountry(String keyword, String sortField, boolean asc);
}
