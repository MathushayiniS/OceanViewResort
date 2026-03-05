package com.oceanview.service;

import com.oceanview.dao.CustomerDAO;
import com.oceanview.model.Customer;

public class CustomerService {

    private CustomerDAO customerDAO;

    public CustomerService() {
        this.customerDAO = new CustomerDAO();
    }

    public boolean emailExists(String email) {
        return customerDAO.emailExists(email);
    }

    public boolean register(String fullName, String email, String phone, String password) {
        if (customerDAO.emailExists(email)) {
            return false; // email already registered
        }
        String hashed = org.mindrot.jbcrypt.BCrypt.hashpw(password, org.mindrot.jbcrypt.BCrypt.gensalt());
        Customer customer = new Customer();
        customer.setFullName(fullName);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setPasswordHash(hashed);
        return customerDAO.registerCustomer(customer);
    }

    public Customer login(String email, String password) {
        return customerDAO.authenticate(email, password);
    }
}
