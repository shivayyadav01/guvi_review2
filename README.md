# 📚 Digital Library Management System

A professional, web-based GUI application to manage library operations efficiently. Built using **Java EE (Jakarta)**, **Servlets**, and **JSP**, following the **MVC (Model-View-Controller)** architecture.

---

## 🚀 Key Features

* **Modern Web-GUI Dashboard:** Real-time statistics including Total Books, Issued Books, and Available Books.
* **Professional Issue & Return:** Track which student has borrowed which book with a dedicated status tracking system.
* **Inventory Management (CRUD):** Easily Add, View, and Delete books from the collection.
* **Visual Status Indicators:** Color-coded badges (Green for Available, Red for Issued) for quick identification.
* **Responsive UI:** Clean and professional interface built with HTML5 and CSS3.

---

## 🛠️ Tech Stack

* **Backend:** Java 21+, Jakarta Servlets 6.0
* **Frontend:** JSP (Java Server Pages), HTML5, CSS3 (Web-based GUI)
* **Server:** Apache Tomcat 10.1
* **Build Tool:** Maven
* **Architecture:** MVC (Model-View-Controller)

---

## 📂 Project Structure



* `src/main/java/com/library/servlet/`: Contains the **Controller** (BookServlet).
* `src/main/java/com/library/model/`: Contains the **Model** (Book class).
* `src/main/java/com/library/dao/`: Contains the **Data Access Object** (In-memory storage logic).
* `src/main/webapp/jsp/`: Contains the **View** (JSP files/Web-GUI).

---

## ⚙️ How to Run

1.  **Clone the project:** ```bash
    git clone [https://github.com/your-username/library-system.git](https://github.com/your-username/library-system.git)
    ```
2.  **Open in IntelliJ IDEA:** Import as a Maven project.
3.  **Configure Tomcat:** Add **Apache Tomcat 10.1** in your Run Configurations.
4.  **Build & Run:** Run the server and access the application at:
    `http://localhost:8080/books?action=home`
 
