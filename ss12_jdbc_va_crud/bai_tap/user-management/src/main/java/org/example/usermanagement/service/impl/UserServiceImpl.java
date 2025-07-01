package org.example.usermanagement.service.impl;

import org.example.usermanagement.entity.User;
import org.example.usermanagement.repository.UserRepository;
import org.example.usermanagement.repository.impl.UserRepositoryImpl;
import org.example.usermanagement.service.UserService;

import javax.validation.*;
import java.util.List;
import java.util.Set;

public class UserServiceImpl implements UserService {
    private static UserRepository userRepository;
    private final Validator validator;

    public UserServiceImpl() {
        userRepository = new UserRepositoryImpl();
        ValidatorFactory vf = Validation.buildDefaultValidatorFactory();
        validator = vf.getValidator();
    }

    @Override
    public List<User> findAll(String sortField, boolean asc) {
        return userRepository.findAll(sortField, asc);
    }

    @Override
    public User findById(Integer id) {
        return userRepository.findById(id);
    }

    @Override
    public boolean add(User user) {
        Set<ConstraintViolation<User>> violations = validator.validate(user);
        if (!violations.isEmpty()) {
            throw new ConstraintViolationException(violations);
        }
        return userRepository.add(user);
    }

    @Override
    public boolean update(User user) {
        Set<ConstraintViolation<User>> violations = validator.validate(user);
        if (!violations.isEmpty()) {
            throw new ConstraintViolationException(violations);
        }
        return userRepository.update(user);
    }

    @Override
    public boolean delete(Integer id) {
        return userRepository.delete(id);
    }

    @Override
    public List<User> searchByCountry(String keyword, String sortField, boolean asc) {
        return userRepository.searchByCountry(keyword, sortField, asc);
    }
}
