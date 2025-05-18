/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.model;

import com.tugas.perpus.util.PasswordHelper;

/**
 *
 * @author LENOVO
 */
public class User {
  private Integer id; // Changed from int to Integer for auto-increment compatibility
  private String name;
  private String email;
  private String phone;
  private String address;
  private String password;
  protected String role;

  public User(Integer id, String name, String email, String phone, String address, String role) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.address = address;
    this.role = role;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public String getName() {
    return name;
  }
  public void setName(String name) {
    this.name = name;
  }

  public String getEmail() {
    return email;
  }
  public void setEmail(String email) {
    this.email = email;
  }

  public String getPhone() {
    return phone;
  }
  public void setPhone(String phone) {
    this.phone = phone;
  }

  public String getAddress() {
    return address;
  }
  public void setAddress(String address) {
    this.address = address;
  }

  public String getPassword() {
    return password;
  }
  public void setPassword(String password) {
    this.password = PasswordHelper.hashPassword(password);
  }

  public String getRole() {
    return role;
  }
  public void setRole(String role) {
    this.role = role;
  }

  public void displayInfo() {
    System.out.println("User ID: " + id);
    System.out.println("Name: " + name);
    System.out.println("Email: " + email);
    System.out.println("Phone: " + phone);
    System.out.println("Address: " + address);
    System.out.println("Role: " + role);
  }
}
