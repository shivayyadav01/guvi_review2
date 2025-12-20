<%@ page import="java.text.DecimalFormat" %>
<%
    Book book = (Book) request.getAttribute("book");
    DecimalFormat df = new DecimalFormat("#,##0.00");
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Book - <%= book.getTitle() %></title>
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

        .book-details {
            background: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .detail-row {
            display: flex;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .detail-label {
            width: 150px;
            font-weight: bold;
            color: #2c3e50;
        }
        .detail-value {
            flex: 1;
        }

        .btn {
            display: inline-block;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 4px;
            margin-right: 10px;
            color: white;
        }
        .btn-edit { background: #f39c12; }
        .btn-back { background: #3498db; }
        .btn-delete { background: #e74c3c; }
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
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
        <h1>Book Details</h1>
        <div>
            <a href="books?action=edit&id=<%= book.getId() %>" class="btn btn-edit">✏️ Edit</a>
            <a href="books" class="btn btn-back">← Back to List</a>
        </div>
    </div>

    <div class="book-details">
        <div class="detail-row">
            <div class="detail-label">Book ID</div>
            <div class="detail-value">#<%= book.getId() %></div>
        </div>

        <div class="detail-row">
            <div class="detail-label">Title</div>
            <div class="detail-value"><strong><%= book.getTitle() %></strong></div>
        </div>

        <div class="detail-row">
            <div class="detail-label">Author</div>
            <div class="detail-value"><%= book.getAuthor() %></div>
        </div>

        <div class="detail-row">
            <div class="detail-label">Price</div>
            <div class="detail-value">₹<%= df.format(book.getPrice()) %></div>
        </div>

        <div class="detail-row">
            <div class="detail-label">Category</div>
            <div class="detail-value"><%= book.getCategory() %></div>
        </div>

        <div class="detail-row">
            <div class="detail-label">ISBN</div>
            <div class="detail-value"><%= book.getIsbn() %></div>
        </div>

        <div class="detail-row">
            <div class="detail-label">Publish Year</div>
            <div class="detail-value"><%= book.getPublishYear() %></div>
        </div>

        <div class="detail-row">
            <div class="detail-label">Status</div>
            <div class="detail-value">
                    <span style="padding: 3px 8px; border-radius: 3px;
                        <% if("AVAILABLE".equals(book.getStatus())) { %>
                            background: #d4edda; color: #155724;
                        <% } else if("ISSUED".equals(book.getStatus())) { %>
                            background: #fff3cd; color: #856404;
                        <% } else { %>
                            background: #f8d7da; color: #721c24;
                            <% } %>">
                        <%= book.getStatus() %>
                    </span>
            </div>
        </div>
    </div>
</div>
</body>
</html>