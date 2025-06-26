package org.example.productdiscountcalculator;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "DiscountServlet", urlPatterns = "/display-discount")
public class DiscountServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");
        String productDescription = request.getParameter("product-description");
        long productPrice = Long.parseLong(request.getParameter("price"));
        int discountPercent = Integer.parseInt(request.getParameter("discount-percent"));
        double discountAmount = productPrice * discountPercent * 0.01;
        double discountPrice = (double) productPrice - discountAmount;
        PrintWriter writer = response.getWriter();
        writer.println("<h1>Kết quả:</h1>");
        writer.println("<p><Strong>Mô tả của sản phẩm: </strong>" + productDescription + "</p>");
        writer.println("<p><Strong>Giá niêm yết của sản phẩm: </strong>" + productPrice + "</p>");
        writer.println("<p><Strong>Tỷ lệ chiết khấu: </strong>" + discountPercent + " (%)</p>");
        writer.println("<hr>");
        writer.println("<p><Strong>Lượng chiết khấu: </strong>" + String.format("%.2f", discountAmount) + "</p>");
        writer.println("<p><Strong>Giá sau khi đã được chiết khấu: </strong>" + String.format("%.2f", discountPrice) + "</p>");
    }
}