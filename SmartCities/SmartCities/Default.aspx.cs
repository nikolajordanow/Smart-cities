using Newtonsoft.Json;
using SmartCities.Controllers;
using SmartCities.DTOs;
using SmartCities.Models;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Web.Services;
using System.Web.UI;

namespace SmartCities
{
    public partial class Default : Page
    {
        [WebMethod]
        public static string GetTraffic(string ageRange, string gender, string minDate, string maxDate)
        {
            DateTime minDateTime = DateTime.ParseExact(minDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);
            DateTime maxDateTime = DateTime.ParseExact(maxDate, "dd/MM/yyyy", CultureInfo.InvariantCulture);

            string[] ageRanges = ageRange.Split(';');

            List<Traffic> trafficList = new List<Traffic>();
            for (int i = 0; i < ageRanges.Length; i++)
            {
                int minAge = int.Parse(ageRanges[i].Split('-')[0]);
                int maxAge = int.Parse(ageRanges[i].Split('-')[1]);

                GetTrafficByCriteriaDto getTrafficByCriteriaDto = new GetTrafficByCriteriaDto
                {
                    MinAge = minAge,
                    MaxAge = maxAge,
                    Gender = gender,
                    MinDateTime = minDateTime,
                    MaxDateTime = maxDateTime
                };
                trafficList.AddRange(new BaseController().GetTrafficByCriteria(getTrafficByCriteriaDto));
            }
            
            return JsonConvert.SerializeObject(trafficList);
        }
    }
}