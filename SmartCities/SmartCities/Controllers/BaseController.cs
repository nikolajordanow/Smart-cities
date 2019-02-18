using SmartCities.DAOs;
using SmartCities.DTOs;
using SmartCities.Models;
using System;
using System.Collections.Generic;

namespace SmartCities.Controllers
{
    public class BaseController
    {
        public void GenerateCustomers()
        {
            CustomerDao customerDao = new CustomerDao();
            customerDao.GenerateCustomers();
        }

        public void GenerateTraffic()
        {
            int cellsCount = 500;
            int trafficForCustomer = 5;
            Random random = new Random();
            TrafficDao trafficDao = new TrafficDao();
            
            List<Customer> allCustomersList = GetAllCustomers();
            foreach (var customer in allCustomersList)
            {
                for (int i = 0; i < trafficForCustomer; i++)
                {
                    List<Cell> cells = Utilities.GetRandomCells(cellsCount);
                    Cell cell = cells[random.Next(0, cellsCount)];

                    Traffic traffic = new Traffic
                    {
                        ANumber = customer.Number,
                        Direction = Utilities.GetTrafficDirection(),
                        BNumber = Utilities.GetRandomTrafficBNumber(),
                        StartDateTime = DateTime.Now.AddDays(new Random().Next(-100, 100)),
                        CellLongitude = cell.Longitude,
                        CellLatitude = cell.Latitude
                    };

                    trafficDao.InsertTraffic(traffic);
                }
            }
        }
        
        public List<Customer> GetAllCustomers()
        {
            List<Customer> allCustomersList = new CustomerDao().GetAllCustomers();
            return allCustomersList;
        }

        public List<Traffic> GetAllTraffic()
        {
            List<Traffic> allTrafficList = new TrafficDao().GetAllTraffic();
            return allTrafficList;
        }

        public List<Traffic> GetTrafficByCriteria(GetTrafficByCriteriaDto getTrafficByCriteriaDto)
        {
            List<Traffic> trafficList = new TrafficDao().GetTrafficByCriteria(getTrafficByCriteriaDto);
            return trafficList;
        }
    }
}