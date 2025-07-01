package org.example.usermanagement.repository;

import org.example.usermanagement.entity.User;

import java.util.List;

public interface UserRepository extends IRepository<User> {
    List<User> searchByCountry(String keyword, String sortField, boolean asc);
}
