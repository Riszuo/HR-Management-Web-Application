using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;


namespace HRWebsite
{
    public partial class Companies : System.Web.UI.Page
    {
        int Comp_ID;
        SqlConnection myCon = new SqlConnection(ConfigurationManager.ConnectionStrings["HRDBConnection"].ConnectionString);
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                DoGridView();
            }

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
        private void DoGridView()
        {
            try
            {
                myCon.Open();
                using (SqlCommand myCom = new SqlCommand("dbo.usp_GetCompanies", myCon))
                {
                    myCom.Connection = myCon;
                    myCom.CommandType = CommandType.StoredProcedure;

                    SqlDataReader myDr = myCom.ExecuteReader();

                    gvCompanies.DataSource = myDr;
                    gvCompanies.DataBind();

                    myDr.Close();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in Companies doGridView: " + ex.Message; }
            finally { myCon.Close(); }
        }
        protected void lbNewComp_Click(object sender, EventArgs e)
        {
            // Redirect if the user is a branch manager
            if (IsBranchManager())
            {
                Response.Redirect("~/Companies.aspx");
                return;
            }

            try
            {
                txtCompanyName.Text = "";
                txtCompAddress.Text = "";
                txtCompContactNo.Text = "";

                lblCompanyNew.Visible = true;
                lblCompanyUpd.Visible = false;
                btnAddCompany.Visible = true;
                btnUpdCompany.Visible = false;

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openCoDetail();", true);
            }
            catch (Exception) { throw; }
        }
        protected void btnAddCompany_Click(object sender, EventArgs e)
        {
            // Redirect if the user is a branch manager
            if (IsBranchManager())
            {
                Response.Redirect("~/Companies.aspx");
                return;
            }

            try
            {
                myCon.Open();
                using (SqlCommand myCom = new SqlCommand("dbo.usp_InsCompany", myCon))
                {
                    myCom.CommandType = CommandType.StoredProcedure;
                    myCom.Parameters.Add("@CompanyName", SqlDbType.VarChar).Value = txtCompanyName.Text;
                    myCom.Parameters.Add("@CompAddress", SqlDbType.VarChar).Value = txtCompAddress.Text;
                    myCom.Parameters.Add("@CompContactNo", SqlDbType.VarChar).Value = txtCompContactNo.Text;

                    myCom.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in btnAddCompany_Click: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }
        protected void btnUpdCompany_Click(object sender, EventArgs e)
        {
            UpdCompany();
            DoGridView();
        }
        protected void gvCompanies_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "UpdCompany")
            {
                Comp_ID = Convert.ToInt32(e.CommandArgument);


                txtCompanyName.Text = "";
                txtCompAddress.Text = "";
                txtCompContactNo.Text = "";

                lblCompanyNew.Visible = false;
                lblCompanyUpd.Visible = true;
                btnAddCompany.Visible = false;
                btnUpdCompany.Visible = true;

                GetCompany(Comp_ID);

                ScriptManager.RegisterStartupScript(this, this.GetType(), "Pop", "openCoDetail();", true);
            }
        }
        protected void gvCompanies_RowDeleting(Object sender, GridViewDeleteEventArgs e)
        {
            // Redirect if the user is a branch manager
            if (IsBranchManager())
            {
                Response.Redirect("~/Companies.aspx");
                return;
            }

            Comp_ID = Convert.ToInt32(gvCompanies.DataKeys[e.RowIndex].Value.ToString());

            try
            {
                myCon.Open();

                using (SqlCommand cmd = new SqlCommand("dbo.usp_DelCompany", myCon))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = Comp_ID;
                    cmd.ExecuteScalar();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in gvCompanies_RowDeleting: " + ex.Message; }
            finally { myCon.Close(); }
            DoGridView();
        }
        private void GetCompany(int Comp_ID)
        {
            try
            {
                myCon.Open();
                using (SqlCommand myCmd = new SqlCommand("dbo.usp_GetCompany", myCon))
                {
                    myCmd.Connection = myCon;
                    myCmd.CommandType = CommandType.StoredProcedure;
                    myCmd.Parameters.Add("@ID", SqlDbType.Int).Value = Comp_ID;
                    SqlDataReader myDr = myCmd.ExecuteReader();

                    if (myDr.HasRows)
                    {
                        while (myDr.Read())
                        {
                            txtCompanyName.Text = myDr.GetValue(1).ToString();
                            txtCompAddress.Text = myDr.GetValue(2).ToString();
                            txtCompContactNo.Text = myDr.GetValue(3).ToString();
                            lblCompID.Text = Comp_ID.ToString();
                        }
                    }
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in Companies GetCompany: " + ex.Message; }
            finally { myCon.Close(); }
        }
        private void UpdCompany()
        {
            // Redirect if the user is a branch manager
            if (IsBranchManager())
            {
                Response.Redirect("~/Companies.aspx");
                return;
            }

            try
            {
                myCon.Open();
                using (SqlCommand cmd = new SqlCommand("dbo.usp_UpdCompany", myCon))
                {
                    cmd.Connection = myCon;
                    cmd.CommandType = CommandType.StoredProcedure;

                    cmd.Parameters.Add("@ID", SqlDbType.Int).Value = int.Parse(lblCompID.Text);
                    cmd.Parameters.Add("@CompanyName", SqlDbType.VarChar).Value = txtCompanyName.Text;
                    cmd.Parameters.Add("@CompAddress", SqlDbType.VarChar).Value = txtCompAddress.Text;
                    cmd.Parameters.Add("@CompContactNo", SqlDbType.VarChar).Value = txtCompContactNo.Text;


                    int rows = cmd.ExecuteNonQuery();
                }
            }
            catch (Exception ex) { lblMessage.Text = "Error in Companies UpdCompany: " + ex.Message; }
            finally { myCon.Close(); }
        }
        protected bool IsBranchManager()
        {
            string role = Session["UserID"]?.ToString();
            return role == "branch_manager";
        }
        protected void GridView1_ItemDataBound(object sender, GridViewRowEventArgs e)
        {
            // Check if the row is in edit mode or is a header/footer row
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                // Find the LinkButton control in the row
                LinkButton lbDelCompany = e.Row.FindControl("lbDelCompany") as LinkButton;

                // Check if the link button is found
                if (lbDelCompany != null)
                {
                    // Check the user's role
                    string role = Session["UserID"]?.ToString();

                    // Disable the link button if the user is a branch manager
                    if (role == "branch_manager")
                    {
                        lbDelCompany.Enabled = false;
                        lbDelCompany.Attributes.Add("style", "color:gray; cursor: not-allowed;"); // Optional: Change style to indicate it's disabled
                    }
                }
            }
        }

        protected string GetClientClickConfirmation()
        {
            if (IsBranchManager())
            {
                return "return false;";
            }
            else
            {
                return "return confirm('Are you sure you want to delete this company?');";
            }
        }

        protected bool GetDeleteButtonEnabled()
        {
            return !IsBranchManager();
        }


    }
}
