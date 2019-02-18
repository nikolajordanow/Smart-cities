using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SmartCities.Models
{
    public class Traffic
    {
        public string ANumber { get; set; }
        public string Direction { get; set; }
        public string BNumber { get; set; }
        public DateTime StartDateTime { get; set; }
        public double CellLongitude { get; set; }
        public double CellLatitude { get; set; }
    }
}