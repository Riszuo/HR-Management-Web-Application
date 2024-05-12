using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRWebsite
{
    public partial class HRUsers : System.Web.UI.Page
    {
        SqlConnection myCon = new SqlConnection(ConfigurationManager.ConnectionStrings["HRDBConnection"].ConnectionString);

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateRolesDropdown();
                DoGridView();
            }

            if (Session["UserID"] == null || string.IsNullOrEmpty(Session["UserID"].ToString()))
            {
                Response.Redirect("~/Login.aspx");
            }
        }

        protected void HomeBtn_Click(object sender, EventArgs e)
        {
            if (Session["UserID"] != null && Session["UserID"].ToString() == "admin")
            {
                Response.Redirect("~/Administration.aspx");
            }
            else
            {
                Response.Redirect("~/Default.aspx");
            }
        }

        private void DoGridView()
        {
            try
            {
                myCon.Open();
                using (SqlCommand myCom = new SqlCommand("SELECT Username, Password, Email, Role FROM Authentication", myCon))
                {
                    SqlDataReader myDr = myCom.ExecuteReader();

                    gvUsers.DataSource = myDr;
                    gvUsers.DataBind();

                    myDr.Close();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in Users doGridView: " + ex.Message; }
            finally { myCon.Close(); }
        }

        protected void lbNewUser_Click(object sender, EventArgs e)
        {
            ClearUserDetails();
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openUserDetail();", true);
            btnAddUser.Visible = true;
            btnUpdUser.Visible = false;
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            try
            {
                myCon.Open();
                using (SqlCommand myCom = new SqlCommand("INSERT INTO Authentication (Username, Password, Email, Role) VALUES (@Username, @Password, @Email, @Role)", myCon))
                {
                    myCom.Parameters.AddWithValue("@Username", txtUsername.Text);
                    myCom.Parameters.AddWithValue("@Password", txtPassword.Text);
                    myCom.Parameters.AddWithValue("@Email", txtEmail.Text);
                    myCom.Parameters.AddWithValue("@Role", ddlRole.SelectedValue); // Retrieve selected role from dropdown list

                    myCom.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblModalMessage.Text = "Error adding user: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }

        protected void btnUpdUser_Click(object sender, EventArgs e)
        {
            UpdUser();
        }

        protected void gvUsers_RowDeleting(Object sender, GridViewDeleteEventArgs e)
        {
            string username = gvUsers.DataKeys[e.RowIndex].Value.ToString();

            try
            {
                myCon.Open();

                using (SqlCommand cmd = new SqlCommand("DELETE FROM Authentication WHERE Username = @Username", myCon))
                {
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error deleting user: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }

        private void ClearUserDetails()
        {
            txtUsername.Text = "";
            txtPassword.Text = "";
            txtEmail.Text = "";
            ddlRole.Text = "";
            lblModalMessage.Text = "";
        }

        private void UpdUser()
        {
            try
            {
                myCon.Open();
                using (SqlCommand cmd = new SqlCommand("UPDATE Authentication SET Password = @Password, Email = @Email, Role = @Role WHERE Username = @Username", myCon))
                {
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text);
                    cmd.Parameters.AddWithValue("@Password", txtPassword.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Role", ddlRole.Text);

                    int rows = cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblModalMessage.Text = "Error updating user: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }

        protected void gvUsers_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvUsers.EditIndex = e.NewEditIndex;
            DoGridView();
            btnAddUser.Visible = false;
            btnUpdUser.Visible = true;
        }

        protected void lbUpdUser_Click(object sender, EventArgs e)
        {
            GridViewRow row = (GridViewRow)((LinkButton)sender).NamingContainer;
            int index = row.RowIndex;

            // Get the data key for the selected row
            string username = gvUsers.DataKeys[index]["Username"].ToString();

            // Retrieve the user details from the GridView and populate the modal fields
            txtUsername.Text = username;
            txtPassword.Text = row.Cells[1].Text; // Assuming Password is in the second column
            txtEmail.Text = row.Cells[2].Text; // Assuming Email is in the third column
            ddlRole.Text = row.Cells[3].Text; // Assuming Role is in the third column

            // Show the Update button and hide the Add button
            btnUpdUser.Visible = true;
            btnAddUser.Visible = false;

            // Display the modal popup
            ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openUserDetail();", true);
        }

        private void PopulateRolesDropdown()
        {
            try
            {
                myCon.Open();
                using (SqlCommand myCom = new SqlCommand("SELECT DISTINCT Role FROM Authentication", myCon))
                {
                    SqlDataReader myDr = myCom.ExecuteReader();
                    ddlRole.DataSource = myDr;
                    ddlRole.DataTextField = "Role";
                    ddlRole.DataValueField = "Role";
                    ddlRole.DataBind();
                    ddlRole.Items.Insert(0, new ListItem("-- Select Role --", "")); // Optional: Add a default option
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error deleting user: " + ex.Message;
            }
            finally
            {
                myCon.Close();
            }
        }


    }
}
