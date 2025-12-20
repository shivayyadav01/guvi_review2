package com.library.dao;

import com.library.model.Book;
import java.util.*;
import java.util.stream.Collectors;

public class BookDAO {
    // In-memory list to store books
    private static List<Book> books = new ArrayList<>();
    private static int idCounter = 1;

    // Static block to add some initial dummy data
    static {
        books.add(new Book(idCounter++, "Java Programming", "James Gosling", 599.0, "Education", "ISBN001"));
        books.add(new Book(idCounter++, "Clean Code", "Robert Martin", 850.0, "Software", "ISBN002"));
        books.add(new Book(idCounter++, "The Alchemist", "Paulo Coelho", 299.0, "Fiction", "ISBN003"));
    }

    // Get all books
    public List<Book> getAllBooks() {
        return new ArrayList<>(books);
    }

    // Add new book
    public void addBook(Book book) {
        book.setId(idCounter++);
        if (book.getStatus() == null) {
            book.setStatus("AVAILABLE");
        }
        books.add(book);
    }

    // Find book by ID
    public Book getBookById(int id) {
        return books.stream()
                .filter(b -> b.getId() == id)
                .findFirst()
                .orElse(null);
    }

    // Delete book
    public void deleteBook(int id) {
        books.removeIf(b -> b.getId() == id);
    }

    // Professional Statistics for Dashboard
    public Map<String, Object> getStatistics() {
        Map<String, Object> stats = new HashMap<>();

        long totalBooks = books.size();
        double totalValue = books.stream().mapToDouble(Book::getPrice).sum();
        double avgPrice = totalBooks > 0 ? totalValue / totalBooks : 0.0;

        // Issued vs Available counts
        long issuedBooks = books.stream().filter(b -> "ISSUED".equals(b.getStatus())).count();
        long availableBooks = totalBooks - issuedBooks;

        long categoriesCount = books.stream().map(Book::getCategory).distinct().count();

        stats.put("totalBooks", totalBooks);
        stats.put("totalValue", totalValue);
        stats.put("avgPrice", avgPrice);
        stats.put("categories", categoriesCount);
        stats.put("issuedBooks", issuedBooks);
        stats.put("availableBooks", availableBooks);

        return stats;
    }
}