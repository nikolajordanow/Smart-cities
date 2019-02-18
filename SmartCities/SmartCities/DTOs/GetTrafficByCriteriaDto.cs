using System;

namespace SmartCities.DTOs
{
    public class GetTrafficByCriteriaDto
    {
        public int MinAge { get; set; }
        public int MaxAge { get; set; }
        public string Gender { get; set; }
        public DateTime MinDateTime { get; set; }
        public DateTime MaxDateTime { get; set; }
    }
}