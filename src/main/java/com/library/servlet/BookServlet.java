package com.library.servlet;

import com.library.model.Book;
import com.library.util.DBConnection;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.*;
import java.util.*;

@WebServlet("/books")
public class BookServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "home";

        try {
            switch (action) {
                case "home": showHome(request, response); break;
                case "list": listBooks(request, response); break;
                case "add": request.getRequestDispatcher("/jsp/add.jsp").forward(request, response); break;
                case "delete": deleteBook(request, response); break;
                case "issuePage": issuePage(request, response); break;
                case "return": returnBook(request, response); break;
                default: response.sendRedirect("books?action=home");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }

    private void showHome(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Book> recentBooks = new ArrayList<>();
        Map<String, Object> stats = new HashMap<>();

        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                // Fetch Recent Books
                ResultSet rs = stmt.executeQuery("SELECT * FROM books ORDER BY id DESC LIMIT 5");
                while (rs.next()) { recentBooks.add(mapResultSetToBook(rs)); }

                // Fetch Stats
                ResultSet rsStats = stmt.executeQuery("SELECT COUNT(*) as total, SUM(price) as val, COUNT(DISTINCT category) as cats FROM books");
                if (rsStats.next()) {
                    int total = rsStats.getInt("total");
                    stats.put("totalBooks", total);
                    stats.put("totalValue", rsStats.getDouble("val"));
                    stats.put("categories", rsStats.getInt("cats"));
                    stats.put("avgPrice", total > 0 ? rsStats.getDouble("val")/total : 0);
                }
            } else { throw new SQLException(); }
        } catch (Exception e) {
            // FALLBACK: Database fail hone par dummy books add karein
            recentBooks = getDefaultBooks();
            stats.put("totalBooks", recentBooks.size());
            stats.put("totalValue", 2950.0);
            stats.put("categories", 3);
            stats.put("avgPrice", 590.0);
            request.setAttribute("dbError", "Offline Mode: Showing default books (Database not connected)");
        }

        request.setAttribute("stats", stats);
        request.setAttribute("recentBooks", recentBooks);
        request.getRequestDispatcher("/jsp/home.jsp").forward(request, response);
    }

    private void listBooks(HttpServletRequest request, HttpServletResponse response) throws Exception {
        List<Book> books = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            if (conn != null) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT * FROM books");
                while (rs.next()) { books.add(mapResultSetToBook(rs)); }
            } else { throw new SQLException(); }
        } catch (Exception e) {
            books = getDefaultBooks();
        }
        request.setAttribute("books", books);
        request.getRequestDispatcher("/jsp/view.jsp").forward(request, response);
    }

    private void issuePage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM books WHERE id = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                request.setAttribute("book", mapResultSetToBook(rs));
                request.getRequestDispatcher("/jsp/issue.jsp").forward(request, response);
            }
        }
    }

    private void returnBook(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("UPDATE books SET status='AVAILABLE', studentName=NULL WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        }
        response.sendRedirect("books?action=list");
    }

    private void deleteBook(HttpServletRequest request, HttpServletResponse response) throws Exception {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("DELETE FROM books WHERE id=?");
            ps.setInt(1, id);
            ps.executeUpdate();
        }
        response.sendRedirect("books?action=list");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String formType = request.getParameter("formType");
        try (Connection conn = DBConnection.getConnection()) {
            if ("add".equals(formType)) {
                PreparedStatement ps = conn.prepareStatement("INSERT INTO books (title, author, category, price, status) VALUES (?,?,?,?,'AVAILABLE')");
                ps.setString(1, request.getParameter("title"));
                ps.setString(2, request.getParameter("author"));
                ps.setString(3, request.getParameter("category"));
                ps.setDouble(4, Double.parseDouble(request.getParameter("price")));
                ps.executeUpdate();
            } else if ("issue".equals(formType)) {
                PreparedStatement ps = conn.prepareStatement("UPDATE books SET status='ISSUED', studentName=? WHERE id=?");
                ps.setString(1, request.getParameter("studentName"));
                ps.setInt(2, Integer.parseInt(request.getParameter("bookId")));
                ps.executeUpdate();
            }
        } catch (Exception e) { e.printStackTrace(); }
        response.sendRedirect("books?action=home");
    }

    // --- Helper Methods ---
    private List<Book> getDefaultBooks() {
        List<Book> list = new ArrayList<>();
        list.add(createDummyBook(101, "Effective Java", "Joshua Bloch", "Technology", 1250.0));
        list.add(createDummyBook(102, "Atomic Habits", "James Clear", "Self-Help", 450.0));
        list.add(createDummyBook(103, "The Alchemist", "Paulo Coelho", "Fiction", 350.0));
        list.add(createDummyBook(104, "Clean Code", "Robert Martin", "Technology", 900.0));
        return list;
    }

    private Book createDummyBook(int id, String t, String a, String c, double p) {
        Book b = new Book(); b.setId(id); b.setTitle(t); b.setAuthor(a); b.setCategory(c); b.setPrice(p); b.setStatus("AVAILABLE");
        return b;
    }

    private Book mapResultSetToBook(ResultSet rs) throws SQLException {
        Book b = new Book();
        b.setId(rs.getInt("id"));
        b.setTitle(rs.getString("title"));
        b.setAuthor(rs.getString("author"));
        b.setCategory(rs.getString("category"));
        b.setPrice(rs.getDouble("price"));
        b.setStatus(rs.getString("status"));
        b.setStudentName(rs.getString("studentName"));
        return b;
    }
}