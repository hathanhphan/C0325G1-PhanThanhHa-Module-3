package org.example.usermanagement.repository.impl;

import org.example.usermanagement.entity.User;
import org.example.usermanagement.repository.UserRepository;
import org.example.usermanagement.utils.DBConnectionUtil;
import org.example.usermanagement.utils.SQLUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;

public class UserRepositoryImpl implements UserRepository {

    private static final String INSERT_USERS_SQL = "insert into users (name, email, country) values (?, ?, ?);";
    private static final String SELECT_USER_BY_ID = "select id,name,email,country from users where id = ?;";
    private static final String SELECT_ALL_USERS = "select id,name,email,country from users;";
    private static final String DELETE_USERS_SQL = "delete from users where id = ?;";
    private static final String UPDATE_USERS_SQL = "update users set name = ?,email= ?, country = ? where id = ?;";
    private static final String SELECT_USERS_BY_COUNTRY_SQL = "select id,name,email,country from users where LOWER(country) like ? COLLATE utf8mb4_general_ci;";

    private static final Set<String> ALLOWED_SORT_FIELDS =
            Set.of("name", "email", "country");

    private static final String BASE_SELECT =
            "SELECT id, name, email, country FROM users";

    @SuppressWarnings("CallToPrintStackTrace")
    @Override
    public List<User> findAll(String sortField, boolean asc) {
        String sql = BASE_SELECT + buildOrderBy(sortField, asc);
        List<User> list = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql);
             ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                list.add(mapRow(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public User findById(Integer id) {
        User user = null;
        try {
            Connection connection = DBConnectionUtil.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID);
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                String name = rs.getString("name");
                String email = rs.getString("email");
                String country = rs.getString("country");
                user = new User(id, name, email, country);
            }
            connection.close();
        } catch (SQLException e) {
            SQLUtil.printSQLException(e);
        }
        return user;
    }

    @Override
    public boolean add(User user) {
        boolean isSuccess = false;
        try {
            Connection connection = DBConnectionUtil.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USERS_SQL);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getCountry());
            isSuccess = preparedStatement.executeUpdate() != 0;
            connection.close();
        } catch (SQLException e) {
            SQLUtil.printSQLException(e);
        }
        return isSuccess;
    }

    @Override
    public boolean update(User user) {
        boolean isSuccess = false;
        try {
            Connection connection = DBConnectionUtil.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USERS_SQL);
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getEmail());
            preparedStatement.setString(3, user.getCountry());
            preparedStatement.setInt(4, user.getId());
            isSuccess = preparedStatement.executeUpdate() != 0;
            connection.close();
        } catch (SQLException e) {
            SQLUtil.printSQLException(e);
        }
        return isSuccess;
    }

    @Override
    public boolean delete(Integer id) {
        boolean isSuccess = false;
        try {
            Connection connection = DBConnectionUtil.getConnection();
            PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USERS_SQL);
            preparedStatement.setInt(1, id);
            isSuccess = preparedStatement.executeUpdate() != 0;
            connection.close();
        } catch (SQLException e) {
            SQLUtil.printSQLException(e);
        }
        return isSuccess;
    }

    @SuppressWarnings("CallToPrintStackTrace")
    @Override
    public List<User> searchByCountry(String keyword, String sortField, boolean asc) {
        String sql = BASE_SELECT
                + " WHERE country COLLATE utf8mb4_general_ci LIKE ?"
                + buildOrderBy(sortField, asc);

        List<User> list = new ArrayList<>();
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, "%" + keyword + "%");
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapRow(rs));
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private String buildOrderBy(String sortField, boolean asc) {
        if (sortField != null
                && ALLOWED_SORT_FIELDS.contains(sortField.toLowerCase())) {
            return " ORDER BY "
                    + sortField
                    + (asc ? " ASC" : " DESC");
        }
        return "";
    }

    private User mapRow(ResultSet rs) throws SQLException {
        return new User(
                rs.getInt("id"),
                rs.getString("name"),
                rs.getString("email"),
                rs.getString("country")
        );
    }
}
