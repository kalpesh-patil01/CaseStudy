<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.ResultSet" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Book Logs</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            background: #f2f5f9;
            margin: 0;
            padding: 25px 15px;
        }

        .container {
            max-width: 1100px;
            margin: auto;
            padding: 20px;
            background: white;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            color: #263238;
        }

        .search-form {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }

        input {
            flex: 1;
            min-width: 0;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        button, .register-btn {
            padding: 10px 16px;
            background: #1976d2;
            color: white;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            cursor: pointer;
        }

        button:hover, .register-btn:hover {
            background: #125ca1;
        }

        .table-wrapper {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: center;
        }

        th {
            background: #1976d2;
            color: white;
        }

        tr:nth-child(even) {
            background: #f5f8fc;
        }

        .empty {
            color: #666;
            padding: 20px;
        }

        .total {
            text-align: right;
            font-size: 18px;
            font-weight: bold;
            margin-top: 15px;
        }

        .footer {
            text-align: center;
            margin-top: 20px;
        }

    </style>
</head>

<body>

<div class="container">

    <h2>Saved Student Logs</h2>

    <h3>Search Book</h3>

    <form class="search-form"
          action="<%= request.getContextPath() %>/booklogs"
          method="post">

        <input type="text"
               name="search"
               placeholder="Enter book name..."
               value="<%= request.getAttribute("search") == null
                       ? ""
                       : request.getAttribute("search") %>">

        <button type="submit">Search</button>

        <a class="register-btn"
           href="<%= request.getContextPath() %>/booklogs">
            Show All
        </a>
    </form>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Student</th>
                    <th>Book</th>
                    <th>Pages Read</th>
                    <th>Date</th>
                </tr>
            </thead>

            <tbody>
            <%
                ResultSet rs = (ResultSet) request.getAttribute("book");
                boolean hasLogs = false;

                if (rs != null) {
                    while (rs.next()) {
                        hasLogs = true;
            %>
                <tr>
                    <td><%= rs.getInt("id") %></td>
                    <td><%= rs.getString("student") == null
                            ? "" : rs.getString("student") %></td>
                    <td><%= rs.getString("book") == null
                            ? "" : rs.getString("book") %></td>
                    <td><%= rs.getInt("pages") %></td>
                    <td><%= rs.getDate("read_on") == null
                            ? "" : rs.getDate("read_on") %></td>
                </tr>
            <%
                    }
                    rs.close();
                }

                if (!hasLogs) {
            %>
                <tr>
                    <td colspan="5" class="empty">
                        No book log records found.
                    </td>
                </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="total">
        Total Pages Read:
        <%= request.getAttribute("totalPages") == null
                ? 0 : request.getAttribute("totalPages") %>
    </div>

    <div class="footer">
        <a class="register-btn"
           href="<%= request.getContextPath() %>/book">
            + Log Another Book
        </a>
    </div>

</div>

</body>
</html>
