<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, com.library.model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Digital Library Management System</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600;700&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #2563eb; --bg: #f8fafc; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); margin: 0; padding: 40px; }
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .stats-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; margin-bottom: 30px; }
        .stat-card { background: white; padding: 25px; border-radius: 15px; box-shadow: 0 4px 6px rgba(0,0,0,0.05); border-left: 5px solid var(--primary); }
        .stat-label { color: #64748b; font-size: 13px; font-weight: 600; text-transform: uppercase; }
        .stat-value { font-size: 28px; font-weight: 700; margin-top: 10px; display: block; }
        .btn { padding: 12px 24px; background: var(--primary); color: white; text-decoration: none; border-radius: 10px; font-weight: 600; font-size: 14px; }
        .table-card { background: white; border-radius: 15px; overflow: hidden; box-shadow: 0 4px 6px rgba(0,0,0,0.05); }
        table { width: 100%; border-collapse: collapse; }
        th { background: #f1f5f9; text-align: left; padding: 15px; color: #475569; font-size: 13px; font-weight: 600; }
        td { padding: 15px; border-bottom: 1px solid #f1f5f9; font-size: 14px; }
        .status { padding: 5px 12px; border-radius: 20px; font-size: 11px; font-weight: 700; }
        .AVAILABLE { background: #dcfce7; color: #166534; }
        .ISSUED { background: #fee2e2; color: #991b1b; }
    </style>
</head>
<body>

<div class="header">
    <h1 style="color: #1e293b; margin: 0; font-weight: 700;">Digital Library Management System</h1>
    <div style="display: flex; gap: 12px;">
        <a href="books?action=list" class="btn" style="background: white; color: var(--primary); border: 1px solid var(--primary);">Full Inventory</a>
        <a href="books?action=add" class="btn">+ Add New Book</a>
    </div>
</div>

<% Map stats = (Map) request.getAttribute("stats"); %>
<div class="stats-grid">
    <div class="stat-card">
        <span class="stat-label">Total Collection</span>
        <span class="stat-value"><%= stats != null ? stats.get("totalBooks") : "0" %></span>
    </div>
    <div class="stat-card" style="border-color: #10b981;">
        <span class="stat-label">Inventory Worth</span>
        <span class="stat-value">₹<%= stats != null ? stats.get("totalValue") : "0.00" %></span>
    </div>
    <div class="stat-card" style="border-color: #f59e0b;">
        <span class="stat-label">Categories</span>
        <span class="stat-value"><%= stats != null ? stats.get("categories") : "0" %></span>
    </div>
</div>

<div class="table-card">
    <div style="padding: 20px; font-weight: 700; font-size: 18px; border-bottom: 1px solid #f1f5f9; color: #1e293b;">Recent Books</div>
    <table>
        <thead>
        <tr>
            <th>Book Title & Author</th>
            <th>Category</th>
            <th>Price</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <% List<Book> recent = (List<Book>) request.getAttribute("recentBooks");
            if(recent != null && !recent.isEmpty()) {
                for(Book b : recent) { %>
        <tr>
            <td>
                <div style="font-weight: 600; color: #334155;"><%= b.getTitle() %></div>
                <div style="color: #94a3b8; font-size: 12px;"><%= b.getAuthor() %></div>
            </td>
            <td><span style="color: #64748b;"><%= b.getCategory() %></span></td>
            <td style="font-weight: 700; color: #334155;">₹<%= b.getPrice() %></td>
            <td><span class="status <%= b.getStatus() %>"><%= b.getStatus() %></span></td>
        </tr>
        <% } } else { %>
        <tr><td colspan="4" style="text-align: center; padding: 40px; color: #94a3b8;">No records found in database.</td></tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>