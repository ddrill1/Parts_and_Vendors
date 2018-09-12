using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;
using System.Web.Services;

namespace PartsAndVendors
{
    public partial class PVMain : System.Web.UI.Page
    {
        public string s;
        public string s2;
        public string valDB;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                mvPV.SetActiveView(masterView);
                Search(0);
            }
        }
        protected void drpSearchBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            s = drpSearchBy.Text;

            if (s != "--Select Field--")
            {
                valDB = (s == "Cage Code" ? "CageCode" : (s == "Parent Assembly" ? "ParentAssy" : (s == "Part Number" ? "PartNum" : s)));

                string con = ConfigurationManager.ConnectionStrings["InteractiveMaterialManagementSystem_TestDBConnectionString"].ConnectionString;
                SqlConnection connection = new SqlConnection(con);

                using (connection)
                {
                    SqlCommand cmd = new SqlCommand("sp_FilterBy", connection);
                    using (cmd)
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@FilterBy", valDB);
                        cmd.Connection = connection;
                        connection.Open();
                        drpSearchFor.DataSource = cmd.ExecuteReader();
                        drpSearchFor.DataTextField = valDB;
                        drpSearchFor.DataBind();
                        connection.Close();
                    }
                    drpSearchFor.Items.Insert(0, new ListItem("--Select " + s + "--", ""));
                }
            }
            else
            {
                drpSearchFor.Items.Clear();
            }
        }
        protected void butSearch_Click(object sender, EventArgs e)
        {
            Search(1);
        }
        public void Search(int x)
        {
            string con = ConfigurationManager.ConnectionStrings["InteractiveMaterialManagementSystem_TestDBConnectionString"].ConnectionString;
            SqlConnection connection = new SqlConnection(con);
            SqlCommand cmd = new SqlCommand("sp_AssyParts2", connection);
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Connection = connection;

            if (x==0)
            {
                cmd.Parameters.AddWithValue("@MasterFilter", 0);
            }
            else
            {
                s = drpSearchBy.Text;
                s2 = drpSearchFor.Text;

                if (s != "--Select Field--" && s2.Substring(0, 2) != "--")
                {
                    valDB = (s == "Cage Code" ? "CageCode" : (s == "Parent Assembly" ? "ParentAssy" : (s == "Part Number" ? "PartNum" : s)));
                    cmd.Parameters.AddWithValue("@Field", s2);
                    cmd.Parameters.AddWithValue("@Column", valDB);
                }
            }

            SqlDataAdapter da = new SqlDataAdapter();
            DataSet ds = new DataSet();

            try
            {
                using (connection)
                {
                    using (cmd)
                    {
                        connection.Open();

                        da = new SqlDataAdapter(cmd);
                        da.Fill(ds);

                        connection.Close();

                        grdMaster.DataSource = ds.Tables[0];
                        grdMaster.DataBind();
                    }
                }
            }
            catch(SqlException)
            {
                grdMaster.DataSource = null;
            }
        }   
        
    }
}