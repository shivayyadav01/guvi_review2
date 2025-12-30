package com.library.dao;

import com.library.model.Book;
import com.library.util.DBConnection;

import java.sql.*;
import java.util.*;

public class BookDAO {

    // 🔹 GET ALL BOOKS
    public List<Book> getAllBooks() {
        List<Book> list = new ArrayList<>();
        String sql = "SELECT * FROM books ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Book b = new Book();
                b.setId(rs.getInt("id"));
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setPrice(rs.getDouble("price"));
                b.setCategory(rs.getString("category"));
                b.setIsbn(rs.getString("isbn"));
                b.setStatus(rs.getString("status"));
                b.setStudentName(rs.getString("student_name"));
                b.setPublishYear(rs.getInt("publish_year"));
                list.add(b);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // 🔹 ADD BOOK
    public void addBook(Book b) {
        String sql = "INSERT INTO books(title,author,price,category,isbn,status,publish_year) VALUES (?,?,?,?,?,?,?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, b.getTitle());
            ps.setString(2, b.getAuthor());
            ps.setDouble(3, b.getPrice());
            ps.setString(4, b.getCategory());
            ps.setString(5, b.getIsbn());
            ps.setString(6, "AVAILABLE");
            ps.setInt(7, b.getPublishYear());

            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🔹 GET BOOK BY ID
    public Book getBookById(int id) {
        String sql = "SELECT * FROM books WHERE id=?";
        Book b = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                b = new Book();
                b.setId(id);
                b.setTitle(rs.getString("title"));
                b.setAuthor(rs.getString("author"));
                b.setPrice(rs.getDouble("price"));
                b.setCategory(rs.getString("category"));
                b.setIsbn(rs.getString("isbn"));
                b.setStatus(rs.getString("status"));
                b.setStudentName(rs.getString("student_name"));
                b.setPublishYear(rs.getInt("publish_year"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return b;
    }

    // 🔹 DELETE BOOK
    public void deleteBook(int id) {
        String sql = "DELETE FROM books WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🔹 ISSUE BOOK
    public void issueBook(int id, String studentName) {
        String sql = "UPDATE books SET status='ISSUED', student_name=? WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, studentName);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 🔹 RETURN BOOK
    public void returnBook(int id) {
        String sql = "UPDATE books SET status='AVAILABLE', student_name=NULL WHERE id=?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
