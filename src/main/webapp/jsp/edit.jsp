<%@ page import="java.text.DecimalFormat" %>
<%
    Book book = (Book) request.getAttribute("book");
    DecimalFormat df = new DecimalFormat("#,##0.00");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Book - <%= book.getTitle() %></title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: Arial, sans-serif; background: #f5f5f5; }

        .navbar {
            background: #2c3e50;
            color: white;
            padding: 15px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .nav-logo { display: flex; align-items: center; gap: 10px; }
        .nav-menu { display: flex; gap: 20px; }
        .nav-menu a {
            color: white;
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 4px;
            transition: background 0.3s;
        }
        .nav-menu a:hover { background: #34495e; }

        .container { max-width: 800px; margin: 20px auto; padding: 0 20px; }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            color: #2c3e50;
            font-weight: bold;
        }
        .form-group input,
        .form-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 16px;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            margin-top: 30px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            text-decoration: none;
            display: inline-block;
        }
        .btn-primary { background: #3498db; color: white; }
        .btn-secondary { background: #95a5a6; color: white; }
        .btn-outline { background: white; color: #2c3e50; border: 1px solid #ddd; }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar">
    <div class="nav-logo">
        <h2>📚 Digital Library</h2>
    </div>
    <div class="nav-menu">
        <a href="books?action=home">🏠 Home</a>
        <a href="books">📖 Books</a>
        <a href="books?action=add">➕ Add Book</a>
        <a href="books?action=statistics">📊 Statistics</a>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div style="margin-bottom: 20px;">
        <h1>Edit Book</h1>
        <p>Update the book details below</p>
    </div>

    <div class="form-container">
        <form action="books" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="id" value="<%= book.getId() %>">

            <div class="form-group">
                <label>Book ID</label>
                <input type="text" value="#<%= book.getId() %>" disabled style="background: #f8f9fa;">
            </div>

            <div class="form-group">
                <label for="title">Book Title</label>
                <input type="text" id="title" name="title" value="<%= book.getTitle() %>" required>
            </div>

            <div class="form-group">
                <label for="author">Author</label>
                <input type="text" id="author" name="author" value="<%= book.getAuthor() %>" required>
            </div>

            <div class="form-group">
                <label for="price">Price (₹)</label>
                <input type="number" id="price" name="price" step="0.01"
                       value="<%= df.format(book.getPrice()) %>" required>
            </div>

            <div class="form-group">
                <label for="category">Category</label>
                <select id="category" name="category" required>
                    <option value="Programming" <%= "Programming".equals(book.getCategory()) ? "selected" : "" %>>Programming</option>
                    <option value="Fiction" <%= "Fiction".equals(book.getCategory()) ? "selected" : "" %>>Fiction</option>
                    <option value="Science" <%= "Science".equals(book.getCategory()) ? "selected" : "" %>>Science</option>
                    <option value="Mathematics" <%= "Mathematics".equals(book.getCategory()) ? "selected" : "" %>>Mathematics</option>
                    <option value="History" <%= "History".equals(book.getCategory()) ? "selected" : "" %>>History</option>
                    <option value="Biography" <%= "Biography".equals(book.getCategory()) ? "selected" : "" %>>Biography</option>
                    <option value="Business" <%= "Business".equals(book.getCategory()) ? "selected" : "" %>>Business</option>
                    <option value="Self-Help" <%= "Self-Help".equals(book.getCategory()) ? "selected" : "" %>>Self-Help</option>
                    <option value="Other" <%= "Other".equals(book.getCategory()) ? "selected" : "" %>>Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="isbn">ISBN</label>
                <input type="text" id="isbn" name="isbn" value="<%= book.getIsbn() != null ? book.getIsbn() : "" %>">
            </div>

            <div class="form-group">
                <label for="publishYear">Publish Year</label>
                <input type="number" id="publishYear" name="publishYear"
                       value="<%= book.getPublishYear() %>" min="1900" max="2024">
            </div>

            <div class="form-group">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="AVAILABLE" <%= "AVAILABLE".equals(book.getStatus()) ? "selected" : "" %>>Available</option>
                    <option value="ISSUED" <%= "ISSUED".equals(book.getStatus()) ? "selected" : "" %>>Issued</option>
                    <option value="LOST" <%= "LOST".equals(book.getStatus()) ? "selected" : "" %>>Lost</option>
                    <option value="RESERVED" <%= "RESERVED".equals(book.getStatus()) ? "selected" : "" %>>Reserved</option>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Update Book</button>
                <a href="books?action=view&id=<%= book.getId() %>" class="btn btn-outline">Cancel</a>
            </div>
        </form>
    </div>
</div>
</body>
</html>