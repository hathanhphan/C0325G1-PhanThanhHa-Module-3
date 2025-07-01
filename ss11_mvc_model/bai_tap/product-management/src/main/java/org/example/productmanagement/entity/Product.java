package org.example.productmanagement.entity;

import javax.validation.constraints.*;

public class Product {
    private String id;

    @NotBlank(message = "Tên sản phẩm không được để trống")
    @Size(min = 2, max = 100, message = "Tên sản phẩm phải từ {min} đến {max} ký tự")
    private String name;


    @NotNull(message = "Giá sản phẩm không được để trống")
    @DecimalMin(value = "0.0", inclusive = false, message = "Giá sản phẩm phải lớn hơn 0")
    @DecimalMax(value = "1000000000.0", inclusive = true, message = "Giá sản phẩm không được vượt quá 1 tỷ")
    private Double price;

    @NotBlank(message = "Mô tả sản phẩm không được để trống")
    @Size(max = 500, message = "Mô tả sản phẩm tối đa {max} ký tự")
    private String description;

    @NotBlank(message = "Tên nhà sản xuất không được để trống")
    @Size(max = 100, message = "Tên nhà sản xuất tối đa {max} ký tự")
    private String manufacturerName;

    public Product() {
    }

    public Product(String id, String name, Double price, String description, String manufacturerName) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.description = description;
        this.manufacturerName = manufacturerName;
    }

    public Product(String name, Double price, String description, String manufacturerName) {
        this.name = name;
        this.price = price;
        this.description = description;
        this.manufacturerName = manufacturerName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Double getPrice() {
        return price;
    }

    public void setPrice(Double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getManufacturerName() {
        return manufacturerName;
    }

    public void setManufacturerName(String manufacturerName) {
        this.manufacturerName = manufacturerName;
    }
}
