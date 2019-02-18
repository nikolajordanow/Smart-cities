using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace SmartCities.DAOs
{
    public class BaseDao
    {
        SqlConnection _connection;
        SqlDataAdapter _adapter;
        string connectionString = @"Data Source=NIKOLA-PC\SQLEXPRESS;Initial Catalog=SMART_CITIES;Integrated Security=true";

        protected DataTable ExecuteQuery(string storedProcedureName, List<SqlParameter> parameters = null)
        {
            DataTable dataTable = new DataTable();
            using (_connection = new SqlConnection(connectionString))
            {
                SqlCommand command = new SqlCommand(storedProcedureName, _connection);
                command.CommandType = System.Data.CommandType.StoredProcedure;

                if (parameters != null)
                {
                    foreach (SqlParameter parameter in parameters)
                    {
                        command.Parameters.AddWithValue(parameter.ParameterName, parameter.Value);
                    }
                }

                try
                {
                    _adapter = new SqlDataAdapter(command);
                    _adapter.Fill(dataTable);
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
                return dataTable;
            }
        }
    }
}