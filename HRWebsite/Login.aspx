<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="HRWebsite.Login" %>
<%@ OutputCache Location="None" NoStore="true" Duration="1" VaryByParam="None" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <%--Disable User from going to previous page--%>
     <script type = "text/javascript" >
         function preventBack() { window.history.forward(); }
         setTimeout("preventBack()", 0);
         window.onunload = function () { null };
     </script>

    <title>Login</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            font-family: Arial, sans-serif;
        }

        form {
            width: 300px; /* Adjust the width as needed */
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f9f9f9;
        }

        .header-text {
            text-align: center;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 15px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            width: 100%;
            padding: 10px;
            border: none;
            background-color: #4caf50;
            color: white;
            cursor: pointer;
            border-radius: 5px;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .message-container {
        text-align: center;
        margin-top: 10px; /* Adjust the margin as needed */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="header-text">
            HR Management
        </div>
        <div>
            <label for="username">Username: 5115 55</label>
            <input type="text" id="TxtUsername" name="username" runat="server" />
            <br />
            <label for="password">Password:</label>
            <input type="password" id="TxtPassword" name="password" runat="server" />
            <br />
            <asp:Button ID="BtnLogin" runat="server" Text="Login" OnClick="BtnLogin_Click" />
            <br />
            <div class="message-container">
                <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
            </div>
        </div>
    </form>
</body>
</html>
