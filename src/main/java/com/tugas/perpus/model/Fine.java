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
import java.time.temporal.ChronoUnit;

public class Fine {
  private Integer id; // Changed from int to Integer for auto-increment compatibility
  private final Transaction transaction;
  private int status; // 0: Unpaid, 1: Paid
  private long totalDenda = 0;

  public Fine(Integer id, Transaction transaction) {
    this.id = id;
    this.transaction = transaction;
    this.status = 0; // Default status: Unpaid
  }

  public double getAmount() {
    LocalDate dueDate = transaction.getDueDate();
    LocalDate today = LocalDate.now();
    double finePerDay = 50000;

    if (today.isAfter(dueDate)) {
      long lateDays = ChronoUnit.DAYS.between(dueDate, today);
      return lateDays * finePerDay;
    }
    return 0.0;
  }

  public Integer getId() {
    return id;
  }

  public void setId(Integer id) {
    this.id = id;
  }

  public Transaction getTransaction() {
    return transaction;
  }

  public int getStatus() {
    return status;
  }
  public void setStatus(int status) {
    this.status = status;
  }

  public long getTotalDenda() {
    return totalDenda;
  }

  public void setTotalDenda(long totalDenda) {
    this.totalDenda = totalDenda;
  }

  public void displayFine() {
    System.out.println("Fine ID: " + id);
    System.out.println("Transaction ID: " + transaction.getId());
    System.out.println("Fine Amount: Rp. " + getAmount());
    System.out.println("Status: " + (status == 1 ? "Paid" : "Unpaid"));
  }
}