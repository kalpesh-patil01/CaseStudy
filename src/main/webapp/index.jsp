<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Log book</title>


<style>
    body {
        font-family: Arial, sans-serif;
        background: #f2f5f9;
        margin: 0;
        padding: 40px 15px;
    }

    .container {
        max-width: 450px;
        margin: auto;
        padding: 25px;
        background: white;
        border-radius: 10px;
        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
    }

    h2 {
        text-align: center;
        color: #263238;
    }

    label {
        display: block;
        margin-top: 15px;
        font-weight: bold;
    }

    input, select {
        width: 100%;
        box-sizing: border-box;
        padding: 10px;
        margin-top: 6px;
        border: 1px solid #ccc;
        border-radius: 5px;
    }

    button {
        width: 100%;
        padding: 12px;
        margin-top: 22px;
        background: #1976d2;
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        font-size: 16px;
    }

    button:hover {
        background: #125ca1;
    }

    .success {
        padding: 10px;
        background: #d4edda;
        color: #155724;
        border-radius: 5px;
    }

    .error {
        padding: 10px;
        background: #f8d7da;
        color: #721c24;
        border-radius: 5px;
    }
</style>


</head>

<body>

<div class="container">

<h2>Log Book</h2>
<% if (request.getAttribute("success") != null) { %>
    <p class="success">
        <%= request.getAttribute("success") %>
    </p>
<% } %>

<% if (request.getAttribute("error") != null) { %>
    <p class="error">
        <%= request.getAttribute("error") %>
    </p>
<% } %>

<form action="<%= request.getContextPath() %>/book"
      method="post">

    <label for="name">Student</label>
    <input type="text" id="name" name="name" required>

    <label for="book">Book</label>
    <input type="text" id="book" name="book" required>

    <label for="pages">Pages Read</label>
    <input type="number" id="pages" name="pages"
           min="0" required>

    <label for="date">Book</label>
    <input type="date" id="date" name="date" required>

    <button type="submit">Save</button>

</form>

<a href="<%= request.getContextPath() %>/booklogs"
   style="display: inline-block;
          margin-top: 30px;
          padding: 10px 20px;
          background-color: #1976d2;
          color: white;
          font-family: Arial, sans-serif;
          font-size: 16px;">
    View Books
</a>

</div>

</body>
</html>
