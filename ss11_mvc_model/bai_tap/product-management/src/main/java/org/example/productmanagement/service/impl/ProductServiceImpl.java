package org.example.productmanagement.service.impl;

import org.example.productmanagement.entity.Product;
import org.example.productmanagement.repository.ProductRepository;
import org.example.productmanagement.repository.impl.ProductRepositoryImpl;
import org.example.productmanagement.service.ProductService;

import javax.validation.*;
import java.util.List;
import java.util.Set;

public class ProductServiceImpl implements ProductService {
    private static ProductRepository productRepository;
    private final Validator validator;

    public ProductServiceImpl() {
        productRepository = new ProductRepositoryImpl();
        ValidatorFactory vf = Validation.buildDefaultValidatorFactory();
        validator = vf.getValidator();
    }

    @Override
    public List<Product> findAll() {
        return productRepository.findAll();
    }

    @Override
    public Product findById(String id) {
        return productRepository.findById(id);
    }

    @Override
    public boolean add(Product product) {
        Set<ConstraintViolation<Product>> violations = validator.validate(product);
        if (!violations.isEmpty()) {
            throw new ConstraintViolationException(violations);
        }
        product.setId(generateId());
        return productRepository.add(product);
    }

    @Override
    public boolean update(Product product) {
        Set<ConstraintViolation<Product>> violations = validator.validate(product);
        if (!violations.isEmpty()) {
            throw new ConstraintViolationException(violations);
        }
        return productRepository.update(product);
    }

    @Override
    public boolean delete(String id) {
        return productRepository.delete(id);
    }

    @Override
    public String generateId() {
        List<Product> products = productRepository.findAll();
        int maxId = products.stream().mapToInt(d -> Integer.parseInt(d.getId().substring(1))).max().orElse(0);
        return String.format("P%06d", maxId + 1);
    }

    @Override
    public List<Product> searchByName(String keyword, boolean caseSensitive, boolean exactMatch) {
        return productRepository.searchByName(keyword, caseSensitive, exactMatch);
    }
}
