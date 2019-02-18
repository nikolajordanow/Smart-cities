using SmartCities.Models;
using System;
using System.Collections.Generic;
using System.Data;

namespace SmartCities.DAOs
{
    public class CustomerDao : BaseDao
    {
        public void GenerateCustomers()
        {
            string generateCustomersStoredProcedure = "GenerateCustomers";
            DataTable dataTable = ExecuteQuery(generateCustomersStoredProcedure);
        }

        public List<Customer> GetAllCustomers()
        {
            string getAllCustomersStoredProcedure = "GetAllCustomers";
            List<Customer> customersList = new List<Customer>();
            DataTable dataTable = ExecuteQuery(getAllCustomersStoredProcedure);

            foreach (DataRow row in dataTable.Rows)
            {
                customersList.Add(MapCustomer(row));
            }

            return customersList;
        }

        private Customer MapCustomer(DataRow row)
        {
            return new Customer
            {
                Number = row["number"].ToString(),
                Gender = row["gender"].ToString(),
                Age = row["age"] != DBNull.Value ? Int32.Parse(row["age"].ToString()) : 0
            };
        }
    }
}