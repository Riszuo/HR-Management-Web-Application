<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="HRUsers.aspx.cs" Inherits="HRWebsite.HRUsers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Users List</title>

    <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
    <script type="text/javascript" src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css" />

    <script type="text/javascript">
        function openUserDetail() {
            $('#modUserDetail').modal('show');
        }
    </script>

    <style>
    .menu-button {
        display: inline-block;
        margin-right: 10px;
    }
    </style>

</head>
<body>
    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
        <div class="container">

            <div class="row">
                <div class="col-xs-12">
                    <h1>Users List</h1>
                </div>
            </div>

            <div class="navbar-collapse collapse">
                <div class="col-sm-4">
                    <ul class="nav navbar-nav" style="font-weight: bold;">
                        <asp:Button ID="BtnHome" runat="server" Text="Home" OnClick="HomeBtn_Click" CssClass="menu-button" />
                    </ul>
                </div>
                <div class="col-sm-4">
                    <asp:Label ID="lblMessage" runat="server" Text="" />
                </div>
                <div class="col-sm-4" style="text-align: right;">
                    <asp:Label ID="Label5" runat="server" Text="[" Font-Size="12px" Visible="true"></asp:Label>
                    <asp:LinkButton ID="lbNewUser" runat="server" Font-Size="12px" OnClick="lbNewUser_Click">New</asp:LinkButton>
                    <asp:Label ID="Label6" runat="server" Text="]" Font-Size="12px" Visible="true"></asp:Label>
                </div>
            </div>

            <div class="row" style="margin-top: 20px;">
                <div class="col-sm-12">
                    <asp:GridView ID="gvUsers" runat="server" AutoGenerateColumns="False" AllowSorting="True"
                        DataKeyNames="Username"
                        CssClass="table table-striped table-bordered table-condensed" BorderColor="Silver"
                        OnRowDeleting="gvUsers_RowDeleting"
                        EmptyDataText="No data for this request!">
                        <Columns>
                            <asp:BoundField DataField="Username" HeaderText="Username">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Password" HeaderText="Password">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Email" HeaderText="Email">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Role" HeaderText="Role">
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Left" />
                            </asp:BoundField>

                            <%-- Delete User --%>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbDelUser" Text="Del" runat="server"
                                        OnClientClick="return confirm('Are you sure you want to delete this user?');" CommandName="Delete" />                                    
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:TemplateField>

                            <%-- Update User --%>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbUpdUser" Text="Upd" runat="server"
                                        OnClick="lbUpdUser_Click" Visible="true" />
                                </ItemTemplate>
                                <HeaderStyle HorizontalAlign="Left" />
                                <ItemStyle HorizontalAlign="Center" Width="80px" />
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
                </div>
            </div>

        </div>

        <div class="modal fade" id="modUserDetail" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" style="width: 600px;">
                <div class="modal-content" style="font-size: 11px;">

                    <div class="modal-header" style="text-align: center;">
                        <asp:Label ID="lblUserNew" runat="server" Text="Add New User" Font-Size="24px" Font-Bold="true" />
                    </div>

                    <div class="modal-body">
                        <div class="row">
                            <div class="col-sm-12">

                                <div class="col-sm-12">
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtUsername" runat="server" MaxLength="50" CssClass="form-control input-xs" 
                                                ToolTip="Username"
                                                AutoCompleteType="Disabled" placeholder="Username" />
                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                    <div class="row" style="margin-top: 20px;">
                                        <div class="col-sm-1"></div>
                                        <div class="col-sm-10">
                                            <asp:TextBox ID="txtPassword" runat="server" MaxLength="50" CssClass="form-control input-xs" 
                                                ToolTip="Password"
                                                AutoCompleteType="Disabled" TextMode="Password" placeholder="Password" />
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
                                            <%--<asp:TextBox ID="txtRole" runat="server" MaxLength="50" CssClass="form-control input-xs" 
                                                ToolTip="Role"
                                                AutoCompleteType="Disabled" placeholder="Role" />--%>
                                            <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-control input-xs" ToolTip="Role" AutoPostBack="false" />

                                        </div>
                                        <div class="col-sm-1">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row" style="margin-top: 20px; margin-bottom: 10px;">
                            <div class="col-sm-1"></div>
                            <div class="col-sm-10">
                                <asp:Label ID="lblModalMessage" runat="server" ForeColor="Red" Font-Size="12px" Text="" />
                            </div>
                            <div class="col-sm-1"></div>
                        </div>
                    </div>

                    <div class="modal-footer">
                        
                        <asp:Button ID="btnUpdUser" runat="server" class="btn btn-warning button-xs" data-dismiss="modal" 
                            Text="Update User"
                            Visible="false" CausesValidation="false"
                            OnClick="btnUpdUser_Click"
                            UseSubmitBehavior="false" />


                        <asp:Button ID="btnAddUser" runat="server" class="btn btn-danger button-xs" data-dismiss="modal" 
                            Text="Add User"
                            Visible="true" CausesValidation="false"
                            OnClick="btnAddUser_Click"
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
