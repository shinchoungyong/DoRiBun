<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 위치 확인 및 주소 변환</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 20px;
        }
        h1 {
            color: #333;
        }
        #address {
            margin-top: 20px;
            font-size: 18px;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <div id="address">주소 정보가 여기에 표시됩니다.</div>

    <script>
        var geocoder; // Reverse Geocoding을 위한 Geocoder 객체

        // 페이지 로드 시 자동으로 위치 정보를 가져오기
        window.onload = function() {
            getLocation();
        };

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError);
            } else {
                document.getElementById("address").innerHTML = "이 브라우저는 위치 정보를 지원하지 않습니다.";
            }
        }

        function showPosition(position) {
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;

            // 주소 변환 (Reverse Geocoding)
            getAddress(latitude, longitude);
        }

        function showError(error) {
            switch(error.code) {
                case error.PERMISSION_DENIED:
                    document.getElementById("address").innerHTML = "사용자가 위치 정보 제공을 거부했습니다.";
                    break;
                case error.POSITION_UNAVAILABLE:
                    document.getElementById("address").innerHTML = "위치 정보를 사용할 수 없습니다.";
                    break;
                case error.TIMEOUT:
                    document.getElementById("address").innerHTML = "위치 정보를 가져오는 데 시간이 초과되었습니다.";
                    break;
                case error.UNKNOWN_ERROR:
                    document.getElementById("address").innerHTML = "알 수 없는 오류가 발생했습니다.";
                    break;
            }
        }

        function getAddress(lat, lng) {
            // Google Geocoding API를 사용하여 좌표를 주소로 변환
            geocoder = new google.maps.Geocoder();
            var latlng = {lat: parseFloat(lat), lng: parseFloat(lng)};
            geocoder.geocode({'location': latlng}, function(results, status) {
                if (status === 'OK') {
                    if (results[0]) {
                        document.getElementById("address").innerHTML = "주소: " + results[0].formatted_address;
                    } else {
                        document.getElementById("address").innerHTML = "주소를 찾을 수 없습니다.";
                    }
                } else {
                    document.getElementById("address").innerHTML = "주소 요청에 실패했습니다: " + status;
                }
            });
        }
    </script>

    <!-- Google Maps API키 입력 -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCkMKSuFICn4ZYgCu-u50vBYzXmLSj8Tuo"></script>

</body>
</html>