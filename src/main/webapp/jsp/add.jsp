<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Book | Library Admin</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;600&display=swap" rel="stylesheet">
    <style>
        :root { --primary: #4f46e5; --bg: #f8fafc; }
        body { font-family: 'Inter', sans-serif; background: var(--bg); display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
        .form-card { background: white; padding: 40px; border-radius: 16px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); width: 100%; max-width: 450px; }
        h2 { margin: 0 0 10px 0; color: #1e293b; font-size: 24px; text-align: center; }
        p { text-align: center; color: #64748b; margin-bottom: 30px; font-size: 14px; }

        .form-group { margin-bottom: 20px; }
        label { display: block; margin-bottom: 8px; font-weight: 600; font-size: 14px; color: #334155; }
        input, select {
            width: 100%; padding: 12px; border: 1px solid #e2e8f0; border-radius: 8px;
            box-sizing: border-box; font-size: 14px; transition: 0.2s;
        }
        input:focus { outline: none; border-color: var(--primary); box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1); }

        .btn-submit {
            width: 100%; background: var(--primary); color: white; padding: 14px;
            border: none; border-radius: 8px; font-weight: 600; cursor: pointer; font-size: 16px; margin-top: 10px;
        }
        .btn-submit:hover { opacity: 0.9; }
        .back-link { display: block; text-align: center; margin-top: 20px; color: #64748b; text-decoration: none; font-size: 14px; }
    </style>
</head>
<body>

<div class="form-card">
    <h2>Add New Book</h2>
    <p>Fill in the details to add a book to the library inventory.</p>

    <form action="books" method="post">
        <input type="hidden" name="formType" value="add">

        <div class="form-group">
            <label>Book Title</label>
            <input type="text" name="title" placeholder="e.g. Clean Code" required>
        </div>

        <div class="form-group">
            <label>Author Name</label>
            <input type="text" name="author" placeholder="e.g. Robert C. Martin" required>
        </div>

        <div class="form-group">
            <label>Category</label>
            <select name="category">
                <option value="Education">Education</option>
                <option value="Fiction">Fiction</option>
                <option value="Technology">Technology</option>
                <option value="Science">Science</option>
                <option value="Business">Business</option>
            </select>
        </div>

        <div class="form-group">
            <label>Price (₹)</label>
            <input type="number" step="0.01" name="price" placeholder="0.00" required>
        </div>

        <button type="submit" class="btn-submit">Save to Inventory</button>
        <a href="books?action=home" class="back-link">← Cancel and Exit</a>
    </form>
</div>

</body>
</html>