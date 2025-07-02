package org.example.usermanagement.controller;

import org.example.usermanagement.entity.User;
import org.example.usermanagement.service.UserService;
import org.example.usermanagement.service.impl.UserServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@WebServlet(name = "userController", urlPatterns = "/user")
public class UserController extends HttpServlet {

    private static final UserService userService = new UserServiceImpl();

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
                resp.sendRedirect(req.getContextPath() + "/user");
        }
    }

    private User parseUserFromRequest(HttpServletRequest req) {
        User user = new User();
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.trim().isEmpty()) {
            try {
                user.setId(Integer.valueOf(idStr));
            } catch (NumberFormatException ignored) {
            }
        }
        user.setName(req.getParameter("name"));
        user.setEmail(req.getParameter("email"));
        user.setCountry(req.getParameter("country"));
        return user;
    }

    private void forwardWithErrors(HttpServletRequest req, HttpServletResponse resp,
                                   User user, ConstraintViolationException ex)
            throws ServletException, IOException {
        Map<String, String> errors = ex.getConstraintViolations().stream()
                .collect(Collectors.toMap(
                        v -> v.getPropertyPath().toString(),
                        ConstraintViolation::getMessage,
                        (m1, m2) -> m1 + "; " + m2
                ));
        req.setAttribute("errors", errors);
        req.setAttribute("user", user);
        req.getRequestDispatcher("WEB-INF/user/save.jsp")
                .forward(req, resp);
    }

    private void getCreate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("user", new User());
        req.getRequestDispatcher("WEB-INF/user/save.jsp").forward(req, resp);
    }

    private void getUpdate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            User existing = userService.findById(Integer.parseInt(id));
            if (existing != null) {
                req.setAttribute("user", existing);
                req.getRequestDispatcher("WEB-INF/user/save.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/user");
            }
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/user");
        }
    }

    private void getDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String id = req.getParameter("id");
            User existing = userService.findById(Integer.parseInt(id));
            if (existing != null) {
                req.setAttribute("user", existing);
                req.getRequestDispatcher("WEB-INF/user/detail.jsp").forward(req, resp);
            } else {
                resp.sendRedirect(req.getContextPath() + "/user");
            }
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/user");
        }
    }

    private void getList(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String q = req.getParameter("q");
        String sortField = req.getParameter("sort");
        String dir = req.getParameter("dir");
        boolean asc = !"desc".equalsIgnoreCase(dir);
        List<User> users = (q != null && !q.isEmpty())
                ? userService.searchByCountry(q, sortField, asc)
                : userService.findAll(sortField, asc);
        req.setAttribute("searchKeyword", q);
        req.setAttribute("currentSort", sortField);
        req.setAttribute("currentDir", dir);
        req.setAttribute("users", users);
        req.getRequestDispatcher("WEB-INF/user/list.jsp")
                .forward(req, resp);
    }

    private void postCreate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, ServletException {
        User user = parseUserFromRequest(req);
        try {
            boolean isSuccess = userService.add(user);
            if (isSuccess) {
                session.setAttribute("successMessage", "Thêm mới người dùng thành công");
            } else {
                session.setAttribute("errorMessage", "Thêm mới người dùng thất bại");
            }
            resp.sendRedirect(req.getContextPath() + "/user");
        } catch (ConstraintViolationException ex) {
            forwardWithErrors(req, resp, user, ex);
        }
    }

    private void postUpdate(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException, ServletException {
        User user = parseUserFromRequest(req);
        try {
            boolean isSuccess = userService.update(user);
            if (isSuccess) {
                session.setAttribute("successMessage", "Cập nhật người dùng thành công");
            } else {
                session.setAttribute("errorMessage", "Cập nhật người dùng thất bại");
            }
            resp.sendRedirect(req.getContextPath() + "/user");
        } catch (ConstraintViolationException ex) {
            forwardWithErrors(req, resp, user, ex);
        }
    }

    private void postDelete(HttpServletRequest req, HttpServletResponse resp, HttpSession session) throws IOException {
        try {
            String id = req.getParameter("id");
            boolean isSuccess = userService.delete(Integer.parseInt(id));
            if (isSuccess) {
                session.setAttribute("successMessage", "Xoá người dùng thành công");
            } else {
                session.setAttribute("errorMessage", "Xoá người dùng thất bại");
            }
            resp.sendRedirect(req.getContextPath() + "/user");
        } catch (NumberFormatException e) {
            System.out.println(e.getMessage());
            resp.sendRedirect(req.getContextPath() + "/user");
        }
    }
}
