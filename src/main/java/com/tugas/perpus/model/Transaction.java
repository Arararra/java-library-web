/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.tugas.perpus.model;

/**
 *
 * @author LENOVO
 */
import java.time.LocalDate;

public class Transaction {
  private Integer id; // Changed from int to Integer for auto-increment compatibility
  private User user;
  private Book book;
  private LocalDate borrowDate; // Date when the book is borrowed
  private LocalDate dueDate; // Date when the book is due to be returned
  private LocalDate returnDate; // Date when the book is actually returned
  private int status; // 0: borrowed, 1: returned, 2: overdue

  public Transaction(Integer id, User user, Book book, LocalDate borrowDate, LocalDate dueDate, int status) {
    this.id = id;
    this.user = user;
    this.book = book;
    this.borrowDate = borrowDate;
    this.dueDate = dueDate;
    this.status = status;
    this.returnDate = null;
  }

  public String getStatusDescription() {
    switch (status) {
      case 0:
        return "Borrowed";
      case 1:
        return "Returned";
      case 2:
        return "Overdue";
      default:
        return "Unknown";
    }
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public User getUser() {
    return user;
  }
  public void setUser(User user) {
    this.user = user;
  }

  public Book getBook() {
    return book;
  }
  public void setBook(Book book) {
    this.book = book;
  }

  public LocalDate getBorrowDate() {
    return borrowDate;
  }
  public void setBorrowDate(LocalDate borrowDate) {
    this.borrowDate = borrowDate;
  }

  public LocalDate getDueDate() {
    return dueDate;
  }
  public void setDueDate(LocalDate dueDate) {
    this.dueDate = dueDate;
  }

  public LocalDate getReturnDate() {
    return returnDate;
  }
  public void setReturnDate(LocalDate returnDate) {
    this.returnDate = returnDate;
  }

  public int getStatus() {
    return status;
  }
  public void setStatus(int status) {
    this.status = status;
  }

  public void displayTransaction() {
    System.out.println("Transaction ID: " + id);
    System.out.println("User: " + user.getName());
    System.out.println("Book: " + book.getTitle());
    System.out.println("Borrow Date: " + borrowDate);
    System.out.println("Due Date: " + dueDate);
    System.out.println("Return Date: " + (returnDate != null ? returnDate : "Not returned yet"));
    System.out.println("Status: " + getStatusDescription());
  }
}
