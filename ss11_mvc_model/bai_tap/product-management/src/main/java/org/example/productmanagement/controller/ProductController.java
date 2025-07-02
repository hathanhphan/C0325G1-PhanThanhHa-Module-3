package org.example.productmanagement.controller;

import org.example.productmanagement.entity.Product;
import org.example.productmanagement.service.ProductService;
import org.example.productmanagement.service.impl.ProductServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.io.IOException;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "productController", urlPatterns = "/product")
public class ProductController extends HttpServlet {

    private static final ProductService productService = new ProductServiceImpl();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        switch (action) {
            case "create":
                getCreate(req, resp);
                break;
            case "update":
                getUpdate(req, resp);
                break;
            case "detail":
                getDetail(req, resp);
                break;
            default:
                getList(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "";
        HttpSession session = req.getSession();
        switch (action) {
            case "create":
                postCreate(req, resp, session);
                return;
            case "update":
                postUpdate(req, resp, session);
                return;
            case "delete":
                postDelete(req, resp, session);
                return;
            default:
                resp.sendRedirect(req.getContextPath() + "/product");
        }
    }

    private Product parseProductFromRequest(HttpServletRequest req) {
        Product p = new Product();
        p.setId(req.getParameter("id"));
        p.setName(req.getParameter("name"));

        String priceStr = req.getParameter("price");
        if (priceStr != null && !priceStr.trim().isEmpty()) {
            priceStr = priceStr.replace(".", "");
            try {
                p.setPrice(Double.valueOf(priceStr));
            } catch (NumberFormatException ignored) {
            }
        }
        p.setDescription(req.getParameter("description"));
        p.setManufacturerName(req.getParameter("manufacturerName"));
        return p;
    }

    private void forwardWithErrors(HttpServletRequest req, HttpServletResponse resp,
                                   Product p, ConstraintViolationException ex)
            throws ServletException, IOException {
        Map<String, String> errors = ex.getConstraintViolations().stream()
                .collect(Collectors.toMap(
                        v -> v.getPropertyPath().toString(),
                        ConstraintViolation::getMessage,
                        (m1, m2) -> m1 + "; " + m2
                ));
        req.setAttribute("errors", errors);
        req.setAttribute("product", p);
        req.getRequestDispatcher("WEB-INF/product/save.jsp")
                .forward(req, resp);
    }

    private void getCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("product", new Product());
        req.getRequestDispatcher("WEB-INF/product/save.jsp").forward(req, resp);
    }

    private void getUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Product existing;
        String id;
        id = req.getParameter("id");
        existing = productService.findById(id);
        if (existing != null) {
            req.setAttribute("product", existing);
            req.getRequestDispatcher("WEB-INF/product/save.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }

    private void getDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Product existing;
        String id;
        id = req.getParameter("id");
        existing = productService.findById(id);
        if (existing != null) {
            req.setAttribute("product", existing);
            req.getRequestDispatcher("WEB-INF/product/detail.jsp").forward(req, resp);
        } else {
            resp.sendRedirect(req.getContextPath() + "/product");
        }
    }

    private void getList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String searchKeyword = req.getParameter("q");
        if (searchKeyword != null && !searchKeyword.isEmpty()) {
            req.setAttribute("searchKeyword", searchKeyword);
            req.setAttribute("products", productService.searchByName(searchKeyword, false, false));
        } else {
            req.setAttribute("products", productService.findAll());
        }
        req.getRequestDispatcher("WEB-INF/product/list.jsp").forward(req, resp);
    }

    private void postCreate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, ServletException {
        Product p = parseProductFromRequest(req);
        try {
            boolean isSuccess = productService.add(p);
            if (isSuccess) {
                session.setAttribute("successMessage", "Thêm mới sản phẩm thành công");
            } else {
                session.setAttribute("errorMessage", "Thêm mới sản phẩm thất bại");
            }
            resp.sendRedirect(req.getContextPath() + "/product");
        } catch (ConstraintViolationException ex) {
            forwardWithErrors(req, resp, p, ex);
        }
    }

    private void postUpdate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, ServletException {
        Product p = parseProductFromRequest(req);
        try {
            boolean isSuccess = productService.update(p);
            if (isSuccess) {
                session.setAttribute("successMessage", "Cập nhật sản phẩm thành công");
            } else {
                session.setAttribute("errorMessage", "Cập nhật sản phẩm thất bại");
            }
            resp.sendRedirect(req.getContextPath() + "/product");
        } catch (ConstraintViolationException ex) {
            forwardWithErrors(req, resp, p, ex);
        }
    }

    private void postDelete(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        boolean isSuccess;
        String id = req.getParameter("id");
        isSuccess = productService.delete(id);
        if (isSuccess) {
            session.setAttribute("successMessage", "Xoá sản phẩm thành công");
        } else {
            session.setAttribute("errorMessage", "Xoá sản phẩm thất bại");
        }
        resp.sendRedirect(req.getContextPath() + "/product");
    }
}
