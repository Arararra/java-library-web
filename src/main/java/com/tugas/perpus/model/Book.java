/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.model;

/**
 *
 * @author LENOVO
 */
public class Book {
  private final int id;
  private String title;
  private Category category;
  private int stock;
  private String author;
  private String publisher;

  public Book(int id, String title, Category category, int stock, String author, String publisher) {
    this.id = id;
    this.title = title;
    this.category = category;
    this.stock = stock;
    this.author = author;
    this.publisher = publisher;
  }

  public int getId() {
    return id;
  }

  public String getTitle() {
    return title;
  }
  public void setTitle(String title) {
    this.title = title;
  }

  public Category getCategory() {
    return category;
  }
  public void setCategory(Category category) {
    this.category = category;
  }

  public int getStock() {
    return stock;
  }
  public void setStock(int stock) {
    this.stock = stock;
  }

  public String getAuthor() {
    return author;
  }
  public void setAuthor(String author) {
    this.author = author;
  }

  public String getPublisher() {
    return publisher;
  }
  public void setPublisher(String publisher) {
    this.publisher = publisher;
  }

  public void displayInfo() {
    System.out.println("Book ID: " + id);
    System.out.println("Title: " + title);
    System.out.println("Category: " + category.getName());
    System.out.println("Stock: " + stock);
    System.out.println("Author: " + author);
    System.out.println("Publisher: " + publisher);
  }
}
