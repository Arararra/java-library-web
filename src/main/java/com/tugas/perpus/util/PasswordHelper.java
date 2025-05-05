/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Main.java to edit this template
 */
package com.tugas.perpus.util;

import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author LENOVO
 */
public class PasswordHelper {
  public static String hashPassword(String plainPassword) {
    return BCrypt.hashpw(plainPassword, BCrypt.gensalt());
  }

  public static boolean verifyPassword(String plainPassword, String hashedPassword) {
    return BCrypt.checkpw(plainPassword, hashedPassword);
  }

  public static void main(String[] args) {
    String password = "anjay";
    
    String hashedPassword = hashPassword(password);
    System.out.println("Hashed Password: " + hashedPassword);

    boolean isMatch = verifyPassword("mySecurePassword", hashedPassword);
    System.out.println("Password Match: " + isMatch);
  }
}
