/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.model;

/**
 *
 * @author LENOVO
 */
public class User {
  private final int id;
  private String name;
  private String email;
  private String phone;
  private String address;
  protected String role;

  public User(int id, String name, String email, String phone, String address, String role) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.address = address;
    this.role = role;
  }

  public int getId() {
    return id;
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
