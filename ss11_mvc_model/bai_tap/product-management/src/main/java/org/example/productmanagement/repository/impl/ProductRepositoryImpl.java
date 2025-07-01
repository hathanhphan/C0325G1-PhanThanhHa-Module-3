package org.example.productmanagement.repository.impl;

import org.example.productmanagement.entity.Product;
import org.example.productmanagement.repository.ProductRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

public class ProductRepositoryImpl implements ProductRepository {
    private static final List<Product> products = new ArrayList<>();

    static {
        products.add(new Product("P000001", "Apple iPhone 14", 20877870.0, "Flagship smartphone 6.1″, A15 Bionic, camera kép 12 MP", "Apple Inc."));
        products.add(new Product("P000002", "Samsung Galaxy S23", 19597238.00, "Android 6.2″ Dynamic AMOLED, Snapdragon 8 Gen 2, 50 MP cam", "Samsung Electronics"));
        products.add(new Product("P000003", "Sony WH-1000XM5", 9145238.0, "Tai nghe không dây chống ồn chủ động, pin 30 giờ", "Sony Corporation"));
        products.add(new Product("P000004", "Dell XPS 13 (9315)", 26103870.0, "Laptop 13.4″ FHD+, Intel Core i5–1230U, 8 GB RAM, 256 GB SSD", "Dell Inc."));
        products.add(new Product("P000005", "Panasonic NR-BK237SSVN", 13822770.0, "Tủ lạnh 2 cửa 236 lít, Inverter, khử mùi Ag Clean", "Panasonic"));
    }

    @Override
    public List<Product> findAll() {
        return products;
    }

    @Override
    public Product findById(String id) {
        for (Product product : products) {
            if (Objects.equals(product.getId(), id)) {
                return product;
            }
        }
        return null;
    }

    @Override
    public boolean add(Product product) {
        products.add(product);
        return true;
    }

    @Override
    public boolean update(Product product) {
        for (int i = 0; i < products.size(); i++) {
            if (Objects.equals(products.get(i).getId(), product.getId())) {
                products.set(i, product);
                return true;
            }
        }
        return false;
    }

    @Override
    public boolean delete(String id) {
        for (int i = 0; i < products.size(); i++) {
            if (products.get(i).getId().equals(id)) {
                products.remove(i);
                return true;
            }
        }
        return false;
    }

    @Override
    public List<Product> searchByName(String keyword, boolean caseSensitive, boolean exactMatch) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return new ArrayList<>();
        }
        String searchKeyword = keyword.trim();
        if (!caseSensitive) {
            searchKeyword = searchKeyword.toLowerCase();
        }
        final String finalKeyword = searchKeyword;
        return products.stream()
                .filter(product -> {
                    String productName = product.getName();
                    if (!caseSensitive) {
                        productName = productName.toLowerCase();
                    }
                    if (exactMatch) {
                        return productName.equals(finalKeyword);
                    } else {
                        return productName.contains(finalKeyword);
                    }
                })
                .collect(Collectors.toList());
    }
}
