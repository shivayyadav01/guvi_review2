package com.library.servlet;

import com.library.dao.BookDAO;
import com.library.model.Book;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.util.*;

@WebServlet(name = "BookServlet", urlPatterns = {"/books", ""})
public class BookServlet extends HttpServlet {
    private BookDAO bookDAO;

    @Override
    public void init() {
        // DAO object ko initialize kar rahe hain
        bookDAO = new BookDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) {
            action = "home";
        }

        try {
            switch (action) {
                case "home":
                    // Dashboard par statistics aur recent books dikhane ke liye
                    request.setAttribute("stats", bookDAO.getStatistics());
                    request.setAttribute("recentBooks", bookDAO.getAllBooks());
                    request.getRequestDispatcher("/jsp/home.jsp").forward(request, response);
                    break;

                case "list":
                    // Saari books ki table dikhane ke liye
                    request.setAttribute("books", bookDAO.getAllBooks());
                    request.getRequestDispatcher("/jsp/books.jsp").forward(request, response);
                    break;

                case "add":
                    // Naya book add karne ka form kholne ke liye
                    request.getRequestDispatcher("/jsp/add.jsp").forward(request, response);
                    break;

                case "issuePage":
                    // Book issue karne ka form kholne ke liye student name input ke saath
                    int issueId = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("book", bookDAO.getBookById(issueId));
                    request.getRequestDispatcher("/jsp/issue.jsp").forward(request, response);
                    break;

                case "return":
                    // Book wapas lene ka logic (AVAILABLE set karna)
                    int returnId = Integer.parseInt(request.getParameter("id"));
                    Book bReturn = bookDAO.getBookById(returnId);
                    if (bReturn != null) {
                        bReturn.setStatus("AVAILABLE");
                        bReturn.setStudentName(null);
                    }
                    response.sendRedirect("books?action=list");
                    break;

                case "delete":
                    // Book delete karne ka logic
                    int deleteId = Integer.parseInt(request.getParameter("id"));
                    bookDAO.deleteBook(deleteId);
                    response.sendRedirect("books?action=list");
                    break;

                default:
                    response.sendRedirect("books?action=home");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        if ("add".equals(action)) {
            // Nayi book save karne ka logic
            Book newBook = new Book();
            newBook.setTitle(request.getParameter("title"));
            newBook.setAuthor(request.getParameter("author"));
            newBook.setCategory(request.getParameter("category"));
            newBook.setPrice(Double.parseDouble(request.getParameter("price")));
            newBook.setIsbn(request.getParameter("isbn"));

            bookDAO.addBook(newBook);
            response.sendRedirect("books?action=list");

        } else if ("issue".equals(action)) {
            // Book kisi student ko assign karne ka logic
            int bookId = Integer.parseInt(request.getParameter("bookId"));
            String studentName = request.getParameter("studentName");

            Book bookToIssue = bookDAO.getBookById(bookId);
            if (bookToIssue != null) {
                bookToIssue.setStatus("ISSUED");
                bookToIssue.setStudentName(studentName);
            }
            response.sendRedirect("books?action=list");
        }
    }
}