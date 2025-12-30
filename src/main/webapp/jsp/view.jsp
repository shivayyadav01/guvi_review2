<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.library.model.Book" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inventory | Library System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #4f46e5; --success: #10b981; --danger: #ef4444; --text: #1e293b; }
        body { font-family: 'Inter', sans-serif; background: #f8fafc; margin: 0; padding: 40px; color: var(--text); }
        .container { max-width: 1200px; margin: auto; background: white; padding: 30px; border-radius: 16px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 2px solid #f1f5f9; padding-bottom: 20px; }

        table { width: 100%; border-collapse: collapse; }
        th { text-align: left; padding: 15px; background: #f1f5f9; color: #64748b; font-size: 13px; text-transform: uppercase; }
        td { padding: 15px; border-bottom: 1px solid #f1f5f9; font-size: 14px; }

        .badge { padding: 5px 12px; border-radius: 99px; font-size: 11px; font-weight: 600; }
        .AVAILABLE { background: #dcfce7; color: #166534; }
        .ISSUED { background: #fee2e2; color: #991b1b; }

        .btn { text-decoration: none; font-weight: 600; font-size: 13px; padding: 6px 12px; border-radius: 6px; transition: 0.2s; }
        .btn-issue { color: var(--primary); border: 1px solid var(--primary); }
        .btn-issue:hover { background: var(--primary); color: white; }
        .btn-return { color: var(--success); border: 1px solid var(--success); }
        .btn-return:hover { background: var(--success); color: white; }
        .btn-delete { color: var(--danger); margin-left: 10px; }
        .btn-back { color: #64748b; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h1>Inventory Management</h1>
        <a href="books?action=home" class="btn-back">← Back to Dashboard</a>
    </div>

    <table>
        <thead>
        <tr>
            <th>Book Title</th>
            <th>Author</th>
            <th>Price</th>
            <th>Status</th>
            <th>Current Holder</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Book> books = (List<Book>) request.getAttribute("books");
            if (books != null) {
                for (Book b : books) {
        %>
        <tr>
            <td style="font-weight: 600;"><%= b.getTitle() %></td>
            <td><%= b.getAuthor() %></td>
            <td>₹<%= b.getPrice() %></td>
            <td><span class="badge <%= b.getStatus() %>"><%= b.getStatus() %></span></td>
            <td><%= b.getStudentName() != null ? b.getStudentName() : "-" %></td>
            <td>
                <% if ("AVAILABLE".equals(b.getStatus())) { %>
                <a href="books?action=issuePage&id=<%= b.getId() %>" class="btn btn-issue">Issue Book</a>
                <% } else { %>
                <a href="books?action=return&id=<%= b.getId() %>" class="btn btn-return">Return Book</a>
                <% } %>
                <a href="books?action=delete&id=<%= b.getId() %>" class="btn btn-delete" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
</div>

</body>
</html>