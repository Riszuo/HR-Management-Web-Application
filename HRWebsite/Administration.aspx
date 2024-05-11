<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Administration.aspx.cs" Inherits="HRWebsite.Administration" %>
<%@ OutputCache Location="None" NoStore="true" Duration="1" VaryByParam="None" %>


<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>HR Database Home Page</title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />

    <style>
    .menu-button {
        display: inline-block;
        margin-right: 10px; /* Adjust as needed */
    }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">

            <%-- Webpage Heading --%>
            <div class="row">
                <div class="col-xs-12">
                    <h1>HR Admin Homepage</h1>
                </div>
            </div>

            <%-- Menu / Message --%>
            <div class="navbar-collapse collapse">
                <div class="col-sm-5">
                    <ul class="nav navbar-nav" style="font-weight: bold;">
                        <asp:Button ID="BtnHome" runat="server" Text="Home" OnClick="HomeBtn_Click" CssClass="menu-button" />
                        <asp:Button ID="BtnCompanies" runat="server" Text="Companies" OnClick="CompaniesBtn_Click" CssClass="menu-button" />
                        <asp:Button ID="BtnEmployees" runat="server" Text="Employees" OnClick="EmployeesBtn_Click" CssClass="menu-button" />  
                        <asp:Button ID="BtnHRUsers" runat="server" Text="HR Users" OnClick="HRUsersBtn_Click" CssClass="menu-button" />
                        <li>
                            <asp:LinkButton ID="hlLogin" runat="server" OnClick="BtnLogout_Click">Logout</asp:LinkButton>
                        </li>
                    </ul>
                </div>
                <div class="col-sm-5">
                    <asp:Label ID="lblMessage" runat="server" Text=""></asp:Label>
                </div>
                <div class="col-sm-5" style="text-align: right;"></div>
            </div>
        </div>
    </form>
</body>
</html>
