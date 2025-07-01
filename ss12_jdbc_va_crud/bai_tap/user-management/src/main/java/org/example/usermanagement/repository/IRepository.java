package org.example.usermanagement.repository;

import java.util.List;

public interface IRepository<T> {
    List<T> findAll(String sortField, boolean asc);
    T findById(Integer id);
    boolean add(T t);
    boolean update(T t);
    boolean delete(Integer id);
}
