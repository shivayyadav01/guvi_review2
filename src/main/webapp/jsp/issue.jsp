<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <title>Issue Book</title>
    <style>
        body { font-family: Arial; background: #f4f7f6; padding: 50px; }
        .card { background: white; padding: 30px; max-width: 400px; margin: auto; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.1); }
        input { width: 100%; padding: 12px; margin: 15px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
        button { background: #3498db; color: white; border: none; padding: 12px; width: 100%; cursor: pointer; border-radius: 4px; font-weight: bold; }
    </style>
</head>
<body>
<div class="card">
    <% Book book = (Book) request.getAttribute("book"); %>
    <h2>Issue Book</h2>
    <p><strong>Book:</strong> <%= book.getTitle() %></p>
    <form action="books" method="POST">
        <input type="hidden" name="action" value="issue">
        <input type="hidden" name="bookId" value="<%= book.getId() %>">
        <input type="text" name="studentName" placeholder="Enter Student Name" required>
        <button type="submit">Confirm Issue</button>
    </form>
    <br>
    <a href="books?action=list">Cancel</a>
</div>
</body>
</html>