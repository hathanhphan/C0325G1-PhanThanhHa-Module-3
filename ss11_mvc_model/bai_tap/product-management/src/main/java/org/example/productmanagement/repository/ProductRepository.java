package org.example.productmanagement.repository;

import org.example.productmanagement.entity.Product;

import java.util.List;

public interface ProductRepository extends IRepository<Product> {
    List<Product> searchByName(String keyword, boolean caseSensitive, boolean exactMatch);
}
