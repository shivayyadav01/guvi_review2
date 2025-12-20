<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.library.model.Book" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<%
    // Attributes fetch kar rahe hain
    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
    List<Book> recentBooks = (List<Book>) request.getAttribute("recentBooks");

    // Default values set kar rahe hain agar stats null ho (safety check)
    if (stats == null) {
        stats = new HashMap<String, Object>();
        stats.put("totalBooks", 0);
        stats.put("totalValue", 0.0);
        stats.put("avgPrice", 0.0);
        stats.put("categories", 0);
    }

    DecimalFormat df = new DecimalFormat("#,##0.00");
%>

<!DOCTYPE html>
<html>
<head>
    <title>Library Dashboard</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }
        .navbar { background: #2c3e50; color: white; padding: 15px 20px; display: flex; justify-content: space-between; align-items: center; }
        .nav-menu { display: flex; gap: 20px; }
        .nav-menu a { color: white; text-decoration: none; padding: 8px 16px; border-radius: 4px; transition: background 0.3s; }
        .nav-menu a:hover { background: #34495e; }
        .nav-menu a.active { background: #3498db; }
        .container { max-width: 1200px; margin: 20px auto; padding: 0 20px; }
        .welcome-section { background: white; padding: 30px; border-radius: 8px; margin-bottom: 20px; }
        .stats-grid { display: grid; grid-template-columns: repeat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin: 20px 0; }
        .stat-card { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); text-align: center;}
        .stat-number { font-size: 1.8em; font-weight: bold; color: #2c3e50; margin-top: 5px; }
        .books-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; }
        .book-card { background: white; border-radius: 8px; padding: 20px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); }
        .btn { display: inline-block; padding: 10px 15px; background: #3498db; color: white; text-decoration: none; border-radius: 4px; font-size: 14px; }
        .footer { text-align: center; padding: 20px; background: #2c3e50; color: white; margin-top: 40px; }
    </style>
</head>
<body>

<nav class="navbar">
    <h2>📚 Digital Library</h2>
    <div class="nav-menu">
        <a href="books?action=home" class="active">🏠 Home</a>
        <a href="books?action=list">📖 Books</a>
        <a href="books?action=add">➕ Add Book</a>
    </div>
</nav>

<div class="container">
    <div class="welcome-section">
        <h1>Welcome to Digital Library</h1>
        <p>Manage your book collection efficiently</p>
    </div>

    <div class="stats-grid">
        <div class="stat-card">
            <h3>Total Books</h3>
            <div class="stat-number"><%= stats.get("totalBooks") %></div>
        </div>
        <div class="stat-card">
            <h3>Total Value</h3>
            <div class="stat-number">₹<%= df.format(stats.get("totalValue")) %></div>
        </div>
        <div class="stat-card">
            <h3>Avg Price</h3>
            <div class="stat-number">₹<%= df.format(stats.get("avgPrice")) %></div>
        </div>
        <div class="stat-card">
            <h3>Categories</h3>
            <div class="stat-number"><%= stats.get("categories") %></div>
        </div>
    </div>

    <h2 style="margin: 30px 0 15px;">Recent Books</h2>
    <div class="books-grid">
        <% if (recentBooks != null && !recentBooks.isEmpty()) {
            for (Book book : recentBooks) { %>
        <div class="book-card">
            <h3><%= book.getTitle() %></h3>
            <p><strong>Author:</strong> <%= book.getAuthor() %></p>
            <p><strong>Category:</strong> <%= book.getCategory() %></p>
            <p><strong>Price:</strong> ₹<%= df.format(book.getPrice()) %></p>
            <div style="margin-top: 15px;">
                <a href="books?action=view&id=<%= book.getId() %>" class="btn">View</a>
                <a href="books?action=edit&id=<%= book.getId() %>" class="btn" style="background: #f39c12;">Edit</a>
            </div>
        </div>
        <% } } else { %>
        <p>No books found. <a href="books?action=add">Add your first book!</a></p>
        <% } %>
    </div>
</div>

<div class="footer">
    <p>&copy; 2025 Digital Library Management System</p>
</div>
</body>
</html>