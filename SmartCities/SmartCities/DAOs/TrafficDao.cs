using SmartCities.DTOs;
using SmartCities.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;

namespace SmartCities.DAOs
{
    public class TrafficDao : BaseDao
    {
        public List<Traffic> GetAllTraffic()
        {
            string getAllTrafficStoredProcedure = "GetAllTraffic";
            List<Traffic> trafficList = new List<Traffic>();
            DataTable dataTable = ExecuteQuery(getAllTrafficStoredProcedure);

            foreach (DataRow row in dataTable.Rows)
            {
                trafficList.Add(MapTraffic(row));
            }

            return trafficList;
        }

        public List<Traffic> GetTrafficByCriteria(GetTrafficByCriteriaDto getTrafficByCriteriaDto)
        {
            string getAllTrafficStoredProcedure = "GetTrafficByCriteria";

            List<SqlParameter> parametersList = new List<SqlParameter>
            {
                new SqlParameter { ParameterName = "@minAge", Value = getTrafficByCriteriaDto.MinAge },
                new SqlParameter { ParameterName = "@maxAge", Value = getTrafficByCriteriaDto.MaxAge },
                new SqlParameter { ParameterName = "@gender", Value = getTrafficByCriteriaDto.Gender },
                new SqlParameter { ParameterName = "@startDate", Value = getTrafficByCriteriaDto.MinDateTime },
                new SqlParameter { ParameterName = "@endDate", Value = getTrafficByCriteriaDto.MaxDateTime }
            };

            DataTable dataTable = ExecuteQuery(getAllTrafficStoredProcedure, parametersList);

            List<Traffic> trafficList = new List<Traffic>();
            foreach (DataRow row in dataTable.Rows)
            {
                trafficList.Add(MapTraffic(row));
            }

            return trafficList;
        }

        public void InsertTraffic(Traffic traffic)
        {
            string insertTrafficStoredProcedure = "InsertTraffic";

            List<SqlParameter> parametersList = new List<SqlParameter>
            {
                new SqlParameter { ParameterName = "aNumber", Value = traffic.ANumber },
                new SqlParameter { ParameterName = "direction", Value = traffic.Direction },
                new SqlParameter { ParameterName = "bNumber", Value = traffic.BNumber },
                new SqlParameter { ParameterName = "startDateTime", Value = traffic.StartDateTime },
                new SqlParameter { ParameterName = "cellLong", Value = traffic.CellLongitude },
                new SqlParameter { ParameterName = "cellLat", Value = traffic.CellLatitude }
            };

            ExecuteQuery(insertTrafficStoredProcedure, parametersList);
        }

        private Traffic MapTraffic(DataRow row)
        {
            return new Traffic
            {
                ANumber = row["aNumber"].ToString(),
                Direction = row["direction"].ToString(),
                BNumber = row["bNumber"].ToString(),
                StartDateTime = row["startDateTime"] != DBNull.Value ? DateTime.Parse(row["startDateTime"].ToString()) : DateTime.MinValue,
                CellLongitude = row["cellLong"] != DBNull.Value ? double.Parse(row["cellLong"].ToString()) : 0,
                CellLatitude = row["cellLat"] != DBNull.Value ? double.Parse(row["cellLat"].ToString()) : 0,
            };
        }
    }
}