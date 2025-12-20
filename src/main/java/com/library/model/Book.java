package com.library.model;

public class Book {
    private int id;
    private String title;
    private String author;
    private double price;
    private String category;
    private String isbn;
    private String status; // AVAILABLE or ISSUED
    private String studentName; // Name of student who borrowed it

    public Book() {
        this.status = "AVAILABLE";
    }

    public Book(int id, String title, String author, double price, String category, String isbn) {
        this.id = id;
        this.title = title;
        this.author = author;
        this.price = price;
        this.category = category;
        this.isbn = isbn;
        this.status = "AVAILABLE";
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public String getIsbn() { return isbn; }
    public void setIsbn(String isbn) { this.isbn = isbn; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getStudentName() { return studentName; }
    public void setStudentName(String studentName) { this.studentName = studentName; }
}