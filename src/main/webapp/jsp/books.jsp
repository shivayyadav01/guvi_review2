<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.library.model.Book" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Books - Digital Library</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Segoe UI', Arial, sans-serif; background: #f4f7f6; color: #333; }

        .navbar {
            background: #2c3e50;
            color: white;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-links a { color: white; text-decoration: none; margin-left: 20px; font-weight: 500; }

        .container { max-width: 1200px; margin: 30px auto; padding: 0 20px; }

        .header-section {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }

        .btn-add {
            background: #3498db;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            font-weight: bold;
        }

        .table-container {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }

        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #eee; }
        th { background: #f8f9fa; color: #7f8c8d; font-size: 13px; text-transform: uppercase; }

        /* Status Badges */
        .badge {
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }
        .badge-available { background: #e8f5e9; color: #2e7d32; }
        .badge-issued { background: #ffebee; color: #c62828; }

        /* Action Buttons */
        .btn-action {
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 13px;
            font-weight: 600;
            display: inline-block;
        }
        .btn-issue { background: #27ae60; color: white; }
        .btn-return { background: #e67e22; color: white; }
        .btn-delete { color: #e74c3c; margin-left: 10px; }

        .student-name { color: #7f8c8d; font-style: italic; font-size: 13px; }
    </style>
</head>
<body>

<nav class="navbar">
    <h2>📚 Digital Library</h2>
    <div class="nav-links">
        <a href="books?action=home">Dashboard</a>
        <a href="books?action=list">Book List</a>
        <a href="books?action=add">Add New Book</a>
    </div>
</nav>

<div class="container">
    <div class="header-section">
        <h1>Library Inventory</h1>
        <a href="books?action=add" class="btn-add">+ Add Book</a>
    </div>

    <div class="table-container">
        <table>
            <thead>
            <tr>
                <th>Book Details</th>
                <th>Category</th>
                <th>Price</th>
                <th>Status</th>
                <th>Issued To</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Book> books = (List<Book>) request.getAttribute("books");
                if (books != null && !books.isEmpty()) {
                    for (Book b : books) {
                        boolean isAvailable = "AVAILABLE".equalsIgnoreCase(b.getStatus());
            %>
            <tr>
                <td>
                    <div style="font-weight: bold;"><%= b.getTitle() %></div>
                    <div style="font-size: 12px; color: #95a5a6;">ISBN: <%= b.getIsbn() %></div>
                </td>
                <td><%= b.getCategory() %></td>
                <td>₹<%= b.getPrice() %></td>
                <td>
                        <span class="badge <%= isAvailable ? "badge-available" : "badge-issued" %>">
                            <%= b.getStatus() %>
                        </span>
                </td>
                <td class="student-name">
                    <%= (b.getStudentName() != null) ? b.getStudentName() : "---" %>
                </td>
                <td>
                    <% if (isAvailable) { %>
                    <a href="books?action=issuePage&id=<%= b.getId() %>" class="btn-action btn-issue">Issue</a>
                    <% } else { %>
                    <a href="books?action=return&id=<%= b.getId() %>" class="btn-action btn-return">Return</a>
                    <% } %>

                    <a href="books?action=delete&id=<%= b.getId() %>" class="btn-delete"
                       onclick="return confirm('Are you sure you want to delete this book?')">Delete</a>
                </td>
            </tr>
            <%      }
            } else {
            %>
            <tr>
                <td colspan="6" style="text-align: center; padding: 40px; color: #95a5a6;">
                    No books found in the library. <a href="books?action=add">Add one now!</a>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>