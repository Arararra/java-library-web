/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.model;

/**
 *
 * @author LENOVO
 */
public class Category {
  private final int id;
  private String name;

  public Category(int id, String name) {
    this.id = id;
    this.name = name;
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

  public void displayCategory() {
    System.out.println("Category ID: " + id);
    System.out.println("Category Name: " + name);
  }
}
