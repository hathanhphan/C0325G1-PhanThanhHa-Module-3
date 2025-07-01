package org.example.productmanagement.service;

import org.example.productmanagement.entity.Product;

import java.util.List;

public interface ProductService extends IService<Product> {
    List<Product> searchByName(String keyword, boolean caseSensitive, boolean exactMatch);
}
