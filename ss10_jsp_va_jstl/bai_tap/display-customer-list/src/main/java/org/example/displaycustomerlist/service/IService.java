package org.example.displaycustomerlist.service;

import java.util.List;

public interface IService <T> {
    List<T> getAll();
}
