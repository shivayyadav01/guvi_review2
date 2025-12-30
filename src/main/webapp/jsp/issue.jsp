<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.library.model.Book" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Issue Book | Library</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Inter', sans-serif; background: #f0f2f5; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .form-card { background: white; padding: 40px; border-radius: 16px; box-shadow: 0 10px 25px rgba(0,0,0,0.1); width: 100%; max-width: 400px; }
        h2 { margin-top: 0; color: #1e293b; font-size: 20px; }
        .book-info { background: #f1f5f9; padding: 15px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 14px; color: #64748b; }
        input[type="text"] { width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px; margin-bottom: 20px; box-sizing: border-box; }
        .btn-submit { width: 100%; background: #4f46e5; color: white; padding: 12px; border: none; border-radius: 8px; font-weight: 600; cursor: pointer; transition: 0.2s; }
        .btn-submit:hover { background: #4338ca; }
        .cancel-link { display: block; text-align: center; margin-top: 15px; color: #64748b; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>

<div class="form-card">
    <% Book b = (Book) request.getAttribute("book"); %>
    <h2>Issue Book</h2>
    <div class="book-info">
        <strong>Book:</strong> <%= b.getTitle() %><br>
        <strong>Author:</strong> <%= b.getAuthor() %>
    </div>

    <form action="books" method="post">
        <input type="hidden" name="formType" value="issue">
        <input type="hidden" name="bookId" value="<%= b.getId() %>">

        <label for="studentName">Student Full Name</label>
        <input type="text" id="studentName" name="studentName" placeholder="Enter student name" required>

        <button type="submit" class="btn-submit">Confirm Transaction</button>
        <a href="books?action=list" class="cancel-link">Cancel and Go Back</a>
    </form>
</div>

</body>
</html>