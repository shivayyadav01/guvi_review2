<!DOCTYPE html>
<html>
<head>
    <title>Add New Book</title>
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
        .nav-menu a.active { background: #3498db; }

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
        .form-group input:focus,
        .form-group select:focus {
            outline: none;
            border-color: #3498db;
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
        .btn-primary {
            background: #3498db;
            color: white;
        }
        .btn-secondary {
            background: #95a5a6;
            color: white;
        }
        .btn-outline {
            background: white;
            color: #2c3e50;
            border: 1px solid #ddd;
        }

        .required::after {
            content: " *";
            color: #e74c3c;
        }
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
        <a href="books?action=add" class="active">➕ Add Book</a>
        <a href="books?action=statistics">📊 Statistics</a>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div style="margin-bottom: 20px;">
        <h1>Add New Book</h1>
        <p>Fill in the book details below</p>
    </div>

    <div class="form-container">
        <form action="books" method="post">
            <input type="hidden" name="action" value="add">

            <div class="form-group">
                <label for="title" class="required">Book Title</label>
                <input type="text" id="title" name="title" required>
            </div>

            <div class="form-group">
                <label for="author" class="required">Author</label>
                <input type="text" id="author" name="author" required>
            </div>

            <div class="form-group">
                <label for="price" class="required">Price (₹)</label>
                <input type="number" id="price" name="price" step="0.01" min="0" required>
            </div>

            <div class="form-group">
                <label for="category" class="required">Category</label>
                <select id="category" name="category" required>
                    <option value="">Select Category</option>
                    <option value="Programming">Programming</option>
                    <option value="Fiction">Fiction</option>
                    <option value="Science">Science</option>
                    <option value="Mathematics">Mathematics</option>
                    <option value="History">History</option>
                    <option value="Biography">Biography</option>
                    <option value="Business">Business</option>
                    <option value="Self-Help">Self-Help</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <div class="form-group">
                <label for="isbn">ISBN</label>
                <input type="text" id="isbn" name="isbn">
            </div>

            <div class="form-group">
                <label for="publishYear">Publish Year</label>
                <input type="number" id="publishYear" name="publishYear" min="1900" max="2024">
            </div>

            <div class="form-group">
                <label for="status">Status</label>
                <select id="status" name="status">
                    <option value="AVAILABLE">Available</option>
                    <option value="ISSUED">Issued</option>
                    <option value="LOST">Lost</option>
                    <option value="RESERVED">Reserved</option>
                </select>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">Add Book</button>
                <button type="reset" class="btn btn-secondary">Clear Form</button>
                <a href="books" class="btn btn-outline">Cancel</a>
            </div>
        </form>
    </div>
</div>

<!-- Footer -->
<div class="footer" style="text-align: center; padding: 20px; margin-top: 40px; background: #2c3e50; color: white;">
    <p>&copy; 2024 Digital Library Management System</p>
</div>
</body>
</html>