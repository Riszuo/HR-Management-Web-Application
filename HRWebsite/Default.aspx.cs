using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace HRWebsite
{
    public partial class Default : System.Web.UI.Page
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
            // Check if the user is admin, head HR manager, or branch manager
            string userID = Session["UserID"].ToString();
            if (userID == "admin" || userID == "hr_manager" || userID == "branch_manager" || userID == "westside_manager")
            {
                Response.Redirect("~/Default.aspx");
            }
            else
            {
                // User not authorized, display pop-up message
                ScriptManager.RegisterStartupScript(this, GetType(), "UnauthorizedAccess", "alert('Unauthorized Access');", true);
            }
        }

        protected void CompaniesBtn_Click(object sender, EventArgs e)
        {
            // Check if the user is admin or head HR manager
            string userID = Session["UserID"].ToString();
            if (userID == "admin" || userID == "hr_manager" || userID == "branch_manager")
            {
                Response.Redirect("~/Companies.aspx");
            }
            else
            {
                // User not authorized, display pop-up message
                ScriptManager.RegisterStartupScript(this, GetType(), "UnauthorizedAccess", "alert('Unauthorized Access');", true);
            }
        }

        protected void EmployeesBtn_Click(object sender, EventArgs e)
        {
            // Check if the user is admin or head HR manager
            string userID = Session["UserID"].ToString();
            if (userID == "admin" || userID == "hr_manager" || userID == "branch_manager" || userID == "westside_manager")
            {
                Response.Redirect("~/Employees.aspx");
            }
            else
            {
                // User not authorized, display pop-up message
                ScriptManager.RegisterStartupScript(this, GetType(), "UnauthorizedAccess", "alert('Unauthorized Access');", true);
            }
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