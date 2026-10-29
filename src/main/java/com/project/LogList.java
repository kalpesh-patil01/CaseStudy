package com.project;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/booklogs")
public class LogList extends HttpServlet {

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        showBooks(request, response, "");
    }

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");

        if (search == null) {
            search = "";
        }

        showBooks(request, response, search);
    }

    private void showBooks(HttpServletRequest request,
            HttpServletResponse response,
            String search)
            throws ServletException, IOException {

        String sql = "SELECT * FROM reading_log WHERE book LIKE ? ORDER BY id DESC";

        try (Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, "%" + search.trim() + "%");

            try (ResultSet rs = ps.executeQuery()) {

                int totalPages = 0;

                while (rs.next()) {
                    totalPages += rs.getInt("pages");
                }

                // displaay thee record again
                try (PreparedStatement ps2 = con.prepareStatement(sql)) {

                    ps2.setString(1, "%" + search.trim() + "%");

                    try (ResultSet book = ps2.executeQuery()) {

                        request.setAttribute("book", book);
                        request.setAttribute("totalPages", totalPages);
                        request.setAttribute("search", search);

                        request.getRequestDispatcher("/result.jsp")
                                .forward(request, response);
                    }
                }
            }

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
