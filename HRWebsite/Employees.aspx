<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Employees.aspx.cs" Inherits="HRWebsite.Employees" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Employees List</title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />

    <script type="text/javascript">
        function openEmpDetail() {
            //alert("Opening modal!");
            $('#modEmpDetail').modal('show');
        }
    </script>

    <style>
    .menu-button {
        display: inline-block;
        margin-right: 10px; /* Adjust as needed */
    }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">

            <%-- Webpage Heading --%>
            <div class="row">
                <div class="col-xs-12">
                    <h1>Employees List</h1>
                </div>
            </div>

            <%-- Menu / Message / New link --%>
            <div class="navbar-collapse collapse">
                <div class="col-sm-4">
                    <ul class="nav navbar-nav" style="font-weight: bold;">
                        <asp:Button ID="BtnHome" runat="server" Text="Home" OnClick="HomeBtn_Click" CssClass="menu-button" />
                        <%--<asp:Button ID="BtnCompanies" runat="server" Text="Companies" OnClick="CompaniesBtn_Click" CssClass="menu-button" />
                        <asp:Button ID="BtnEmployees" runat="server" Text="Employees" OnClick="EmployeesBtn_Click" CssClass="menu-button" />--%>
                    </ul>
                </div>
                <div class="col-sm-4">
                    <asp:Label ID="lblMessage" runat="server" Text="" />
                </div>
                <div class="col-sm-4" style="text-align: right;">
                    <asp:Label ID="Label5" runat="server" Text="[" Font-Size="12px" Visible="true"></asp:Label>
                    <asp:LinkButton ID="lbNewEmp" runat="server" Font-Size="12px" OnClick="lbNewEmp_Click">New</asp:LinkButton>
                    <asp:Label ID="Label6" runat="server" Text="]" Font-Size="12px" Visible="true"></asp:Label>
                </div>
            </div>

            <%-- Gridview --%>
            <div class="row" style="margin-top: 20px;">
                <div class="col-sm-12">
                    <asp:GridView ID="gvEmployees" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                        DataKeyNames="ID"
                        CssClass="table table-striped table-bordered table-condensed" BorderColor="Silver"
                        OnRowDeleting="gvEmployees_RowDeleting"
                        OnRowCommand="gvEmployees_RowCommand"
                        EmptyDataText="No data for this request!">
                        <Columns>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <%# Container.DataItemIndex + 1 %>
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" Width="25px" />
                                <ItemStyle HorizontalAlign="Left" Font-Bold="true" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ContactNo" HeaderText="Contact Number">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Email" HeaderText="Email">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CompanyName" HeaderText="Company">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                            <%-- Delete Employee --%>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbDelCompany" Text="Del" runat="server"
                                        OnClientClick='<%# GetClientClickConfirmation() %>'
                                        CommandName="Delete" Enabled='<%# GetDeleteButtonEnabled() %>' />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>

                            <%-- Update Employee --%>
                            <asp:TemplateField HeaderText="">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbUpdEmployee" runat="server" CommandArgument='<%# Eval("ID") %>'
                                        CommandName="UpdEmployee" Text="Upd" CausesValidation="false"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="80px" />
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>

        <!-- Modal to Add New or View / Update a Company Details-->
        <div class="modal fade" id="modEmpDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" style="width: 600px;">
                <div class="modal-content" style="font-size: 11px;">

                    <div class="modal-header" style="text-align: center;">
                        <asp:Label ID="lblEmployeeNew" runat="server" Text="Add New Employee" Font-Size="24px" Font-Bold="true" />
                        <asp:Label ID="lblEmployeeUpd" runat="server" Text="View / Update an Employee" Font-Size="24px" Font-Bold="true" />
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">

                                <%-- Employee Details Textboxes --%>
                                <div class="col-sm-12">
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtEmployeeName" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Employee Name"
                                                AutoCompleteType="Disabled" placeholder="Employee Name" />
                                            <asp:Label runat="server" ID="lblEmpID" Visible="false" Font-Size="12px" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtContactNo" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Contact Number"
                                                AutoCompleteType="Disabled" placeholder="Contact Number" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtEmail" runat="server" MaxLength="255" CssClass="form-control input-xs" 
                                                ToolTip="Email"
                                                AutoCompleteType="Disabled" placeholder="Email" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:DropDownList ID="ddlCompany" runat="server" CssClass="form-control input-xs" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <%-- Message label on modal page --%>
                        <div class="row" style="margin-top: 20px; margin-bottom: 10px;">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-10">
                                <asp:Label ID="lblModalMessage" runat="server" ForeColor="Red" Font-Size="12px" Text="" />
                            </div>
                            <div class="col-sm-1"></div>
                        </div>
                    </div>

                    <%-- Add, Update and Cancel Buttons --%>
                    <div class="modal-footer">
                        <asp:Button ID="btnAddEmployee" runat="server" class="btn btn-danger button-xs" data-dismiss="modal" 
                            Text="Add Employee"
                            Visible="true" CausesValidation="false"
                            OnClick="btnAddEmployee_Click"
                            UseSubmitBehavior="false" />
                        <asp:Button ID="btnUpdEmployee" runat="server" class="btn btn-danger button-xs" data-dismiss="modal" 
                            Text="Update Employee"
                            Visible="false" CausesValidation="false"
                            OnClick="btnUpdEmployee_Click"
                            UseSubmitBehavior="false" />
                        <asp:Button ID="btnClose" runat="server" class="btn btn-info button-xs" data-dismiss="modal" Text="Close" 
                            CausesValidation="false"
                            UseSubmitBehavior="false" />
                    </div>

                </div>
            </div>
        </div>
    </form>
</body>
</html>

