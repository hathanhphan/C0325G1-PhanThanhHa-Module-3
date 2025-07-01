package org.example.productmanagement.repository;

import java.util.List;

public interface IRepository<T> {
    List<T> findAll();
    T findById(String id);
    boolean add(T t);
    boolean update(T t);
    boolean delete(String id);
}
