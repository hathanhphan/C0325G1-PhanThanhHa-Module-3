package org.example.usermanagement.service;

import java.util.List;

public interface IService <T> {
    List<T> findAll(String sortField, boolean asc);
    T findById(Integer id);
    boolean add(T t);
    boolean update(T t);
    boolean delete(Integer id);
}
