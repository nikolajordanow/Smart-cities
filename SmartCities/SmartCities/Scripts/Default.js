(function () {
    $(document).ready(function () {
        var map = L.map('mapid').setView([48.148598, 17.107748], 10);
        var _this = this;
        this.mapMarkers = [];
        L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token={accessToken}', {
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
            maxZoom: 18,
            id: 'mapbox.streets',
            accessToken: 'pk.eyJ1Ijoibmlrb2xham9yZGFub3ciLCJhIjoiY2pzN25ycDlwMHR3MTN6czhlcTJxdDI5MCJ9.LWoZZAAxZn0CtXEppT5nKg'
        }).addTo(map);
        $('#minDate').datepicker({
            autoclose: true,
            format: "dd/mm/yyyy"
        });
        $('#maxDate').datepicker({
            autoclose: true,
            format: "dd/mm/yyyy"
        });
        $('#ageSelector').multiselect();
        $('#genderSelector').multiselect();

        function setMarker(traffic) {
            var marker = L.marker([traffic.CellLatitude, traffic.CellLongitude]).addTo(map)
            .bindPopup(traffic.ANumber)
            .openPopup();

            _this.mapMarkers.push(marker);
        }

        function callServer(methodUrl, objParameter, successFunc) {
            $.ajax({
                type: 'POST',
                url: methodUrl,
                data: JSON.stringify(objParameter),
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: function (response) {
                    var data = JSON.parse(response.d);
                    successFunc(data);
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
        
        function getAgeRange() {
            var selectedValues = $('#ageSelector').val();
            
            if (!selectedValues) {
                return "";
            }

            var ageRange = "";
            for (var i = 0; i < selectedValues.length; i++) {
                ageRange += selectedValues[i];

                if (i != selectedValues.length - 1) {
                    ageRange += ";";
                }
            }
            return ageRange;
        }

        function getGender(){
            var selectedValues = $('#genderSelector').val();
            return selectedValues[0];
        }

        function getMinDate() {
            return $('#minDate').val();
        }

        function getMaxDate() {
            return $('#maxDate').val();;
        }

        function getSearchParameters() {
            var obj = {};
            obj.ageRange = getAgeRange();
            obj.gender = getGender();
            obj.minDate = getMinDate();
            obj.maxDate = getMaxDate();

            return obj;
        }

        function setCount(count) {
            $('#spCount').text(count);
        }

        function clearMarkers() {
            if (_this.mapMarkers) {
                for (var i = 0; i < _this.mapMarkers.length; i++) {
                    map.removeLayer(_this.mapMarkers[i]);
                }
            }
        }

        $('#btnSearchTraffic').click(function () {
            var searchParams = getSearchParameters();

            if (!searchParams)
            {
                return;
            }
            else if(searchParams.ageRange == ""){
                alert('Please choose an age group!');
                return;
            }
            else if(searchParams.minDate == ""){
                alert('Please choose min date!');
                return;
            }
            else if(searchParams.maxDate == ""){
                alert('Please choose max date!');
                return;
            }

            callServer('Default.aspx/GetTraffic', searchParams, function (trafficList) {
                clearMarkers();
                setCount(trafficList.length);
                for (var i = 0; i < trafficList.length; i++) {
                    setMarker(trafficList[i]);
                }
            });
        });
    });
})();