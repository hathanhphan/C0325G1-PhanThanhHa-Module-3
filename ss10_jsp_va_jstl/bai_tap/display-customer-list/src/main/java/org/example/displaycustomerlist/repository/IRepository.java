package org.example.displaycustomerlist.repository;

import java.util.List;

public interface IRepository<T> {
    List<T> findAll();
}
