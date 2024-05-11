using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRWebsite
{
    public partial class Administration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Check if the UserID session variable exists and if it contains a value
            if (Session["UserID"] == null || string.IsNullOrEmpty(Session["UserID"].ToString()))
            {
                // User not authenticated, redirect to login page
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

        protected void CompaniesBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Companies.aspx");
        }

        protected void EmployeesBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Employees.aspx");
        }

        protected void HRUsersBtn_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/HRUsers.aspx");
        }

        protected void BtnLogout_Click(object sender, EventArgs e)
        {
            // End session
            Session.Clear(); // Clear session data
            Session.Abandon(); // Abandon session

            // Check if the session has ended
            if (Session["UserID"] == null || string.IsNullOrEmpty(Session["UserID"].ToString()))
            {
                // Redirect to login page
                Response.Redirect("~/Login.aspx");
            }
        }
    }
}