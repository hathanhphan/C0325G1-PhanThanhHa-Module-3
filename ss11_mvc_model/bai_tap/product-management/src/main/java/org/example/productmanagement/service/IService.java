package org.example.productmanagement.service;

import java.util.List;

public interface IService <T> {
    List<T> findAll();
    T findById(String id);
    boolean add(T t);
    boolean update(T t);
    boolean delete(String id);
    String generateId();
}
