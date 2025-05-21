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
  private Integer id;
  private User user;
  private Book book;
  private LocalDate borrowDate;
  private LocalDate dueDate;
  private LocalDate returnDate;

  public Transaction(Integer id, User user, Book book, LocalDate borrowDate, LocalDate dueDate) {
    this.id = id;
    this.user = user;
    this.book = book;
    this.borrowDate = borrowDate;
    this.dueDate = dueDate;
    this.returnDate = null;
  }

  public int getStatus() {
    if (returnDate != null) {
      return 1; // returned
    } else if (dueDate != null && LocalDate.now().isAfter(dueDate)) {
      return 2; // overdue
    } else {
      return 0; // borrowed
    }
  }

  public String getStatusDescription() {
    switch (getStatus()) {
      case 0:
        return "Borrowing";
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
