/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.model;

/**
 *
 * @author LENOVO
 */
class Member extends User {
  public Member(int id, String name, String email, String phone, String address) {
    super(id, name, email, phone, address, "member");
  }
  
  public void borrowBook() {
  }
  
  public void returnBook() {
  }
}
