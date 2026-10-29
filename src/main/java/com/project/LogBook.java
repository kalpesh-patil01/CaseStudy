package com.project;

import java.io.IOException;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Calendar;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/book")
public class LogBook  extends HttpServlet{
    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher("/index.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        // get data
        String name = request.getParameter("name");
        String book = request.getParameter("book");
        String pages = request.getParameter("pages");
        String date = request.getParameter("date");

        if (name == null || name.trim().isEmpty()) {
            showError(request, response, "Student name is required.");
            return;
        }

        if (book == null || book.trim().isEmpty()) {
            showError(request, response, "Book name is required.");
            return;
        }

        if (pages == null || pages.trim().isEmpty()) {
            showError(request, response, "Pages is required.");
            return;
        }

        if (date == null || date.trim().isEmpty()) {
            showError(request, response, "Date is required.");
            return;
        }

        String sql = "INSERT INTO reading_log (student, book, pages, read_on) "
                + "VALUES (?, ?, ?, ?)";

        try (
                Connection connection = DBConnection.getConnection();
                PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, name.trim());
            statement.setString(2, book.trim());
            statement.setInt(3, Integer.parseInt(pages.trim()));
            statement.setDate(4, Date.valueOf(date));

            int rowsInserted = statement.executeUpdate();

            if (rowsInserted > 0) {
                request.setAttribute(
                        "success",
                        "Book log registered successfully.");
            } else {
                request.setAttribute(
                        "error",
                        "Book registration failed try again");
            }

        } catch (SQLException e) {
                request.setAttribute(
                    "error",
                    "database error: " + e.getMessage());
        }

        request.getRequestDispatcher("/index.jsp")
                .forward(request, response);
    }

    private void showError(HttpServletRequest request,
            HttpServletResponse response,
            String message)
            throws ServletException, IOException {

        request.setAttribute("error", message);

        request.getRequestDispatcher("/index.jsp")
                .forward(request, response);
    }
}
