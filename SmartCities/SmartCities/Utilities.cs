using SmartCities.Models;
using System;
using System.Collections.Generic;

namespace SmartCities
{
    public static class Utilities
    {
        public static List<Cell> GetRandomCells(int count)
        {
            List<Cell> cellsList = new List<Cell>();
            Random random = new Random();

            do
            {
                cellsList.Add(
                    new Cell
                    {
                        Longitude = random.NextDouble() + 17,
                        Latitude = random.NextDouble() + 48
                    });
            }
            while (cellsList.Count != count);

            return cellsList;
        }

        public static string GetRandomTrafficBNumber()
        {
            switch (new Random().Next(1, 4))
            {
                case 1:
                    return "tbaslacte";
                case 2:
                    return "ebanab";
                case 3:
                    return "HTML:internet/000";
                case 4:
                    return "blsl";
                default:
                    return "";
            }
        }
        
        public static string GetTrafficDirection()
        {
            return "=>";
        }
    }
}