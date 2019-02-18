using SmartCities.Controllers;
using SmartCities.DAOs;
using SmartCities.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SmartCities
{
    public partial class DataPreparation : Page
    {
        BaseController _controller = new BaseController();
        
        protected void btnGenerateCustomers_Click(object sender, EventArgs e)
        {
            _controller.GenerateCustomers();
        }

        protected void btnGenerateTraffic_Click(object sender, EventArgs e)
        {
            _controller.GenerateTraffic();    
        }
    }
}