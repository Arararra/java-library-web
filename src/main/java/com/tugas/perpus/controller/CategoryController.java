/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.controller;

import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author LENOVO
 */
public class CategoryController {
  private List<String> categories;

  public CategoryController() {
    categories = new ArrayList<>();
  }

  public void addCategory(String categoryName) {
    if (categoryName != null && !categoryName.trim().isEmpty()) {
      categories.add(categoryName);
    }
  }

  public List<String> getCategories() {
    return categories;
  }
}
