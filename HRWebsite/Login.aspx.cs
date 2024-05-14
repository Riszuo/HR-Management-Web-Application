using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;

namespace HRWebsite
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            // Construct connection string
            string connectionString = "Data Source=MYSERVER\\SQLEXPRESS;Initial Catalog=HRDatabase;Integrated Security=True";

            // Construct SQL query
            string query = "SELECT Role FROM dbo.Authentication WHERE Username=@username AND Password=@password";

            // Establish SQL connection
            using (SqlConnection con = new SqlConnection(connectionString))
            {
                // Prepare SQL command
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    // Set parameters
                    cmd.Parameters.AddWithValue("@username", TxtUsername.Value);
                    cmd.Parameters.AddWithValue("@password", TxtPassword.Value);

                    // Open the connection
                    con.Open();

                    // Execute the query and get the role of the user
                    object roleObj = cmd.ExecuteScalar();

                    if (roleObj != null)
                    {
                        string role = roleObj.ToString();

                        // Create session based on role
                        switch (role)
                        {
                            case "Admin":
                                Session["UserID"] = "admin";
                                Response.Redirect("Administration.aspx");
                                break;
                            case "Head HR Manager":
                                Session["UserID"] = "hr_manager";
                                Response.Redirect("Default.aspx");
                                break;
                            case "Branch Manager":
                                Session["UserID"] = "branch_manager";
                                Response.Redirect("Default.aspx");
                                break;
                            case "Westside Manager":
                                Session["UserID"] = "westside_manager";
                                Response.Redirect("Default.aspx");
                                break;
                            default:
                                lblMessage.Text = "Invalid Role";
                                break;
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Invalid Username or Password";
                    }
                }
            }
        }


    }
}