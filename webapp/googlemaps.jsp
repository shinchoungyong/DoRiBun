<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 위치 및 주변 추천 장소</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            padding: 20px;
            background-color: #f7f7f7;
        }
        h1 {
            color: #333;
        }
        #map {
            width: 100%;
            height: 400px;
            margin-top: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        #coordinates {
            margin-top: 20px;
            font-size: 18px;
        }
        #places {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            margin-top: 20px;
        }
        .place-card {
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
            width: 300px;
            padding: 20px;
            margin: 10px;
            text-align: left;
            transition: box-shadow 0.3s ease;
        }
        .place-card:hover {
            box-shadow: 0 4px 16px rgba(0, 0, 0, 0.15);
        }
        .place-name {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .place-address {
            color: #555;
            font-size: 14px;
            margin-bottom: 10px;
        }
        .place-rating {
            color: #f39c12;
            font-size: 14px;
            font-weight: bold;
        }
    </style>
</head>
<body>
	<!-- 9/19 3:42 반경1KM 내에 추천장소 띄우기 -->
    <h1>내 위치 및 주변 추천 장소</h1>
    <p>GPS를 사용하여 현재 위치를 확인하고, 근처의 가볼만한 장소를 추천해 드립니다.</p>

    <div id="coordinates"></div>
    <div id="map"></div>
    <div id="places"></div>

    <script>
        var map;
        var service;
        var infowindow;
        var mapInitialized = false;

        // 페이지가 로드되면 자동으로 위치 가져오기
        window.onload = function() {
            getLocation();
        };

        function getLocation() {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(showPosition, showError);
            } else {
                document.getElementById("coordinates").innerHTML = "이 브라우저는 위치 정보를 지원하지 않습니다.";
            }
        }

        function showPosition(position) {
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;
            document.getElementById("coordinates").innerHTML = "위도: " + latitude + ", 경도: " + longitude;

            if (!mapInitialized) {
                initMap(latitude, longitude);
                mapInitialized = true;
            } else {
                updateMap(latitude, longitude);
            }

            // 주변 장소 검색
            searchNearby(latitude, longitude);
        }

        function showError(error) {
            switch(error.code) {
                case error.PERMISSION_DENIED:
                    document.getElementById("coordinates").innerHTML = "사용자가 위치 정보 제공을 거부했습니다.";
                    break;
                case error.POSITION_UNAVAILABLE:
                    document.getElementById("coordinates").innerHTML = "위치 정보를 사용할 수 없습니다.";
                    break;
                case error.TIMEOUT:
                    document.getElementById("coordinates").innerHTML = "위치 정보를 가져오는 데 시간이 초과되었습니다.";
                    break;
                case error.UNKNOWN_ERROR:
                    document.getElementById("coordinates").innerHTML = "알 수 없는 오류가 발생했습니다.";
                    break;
            }
        }

        function initMap(lat, lng) {
            var location = new google.maps.LatLng(lat, lng);
            map = new google.maps.Map(document.getElementById('map'), {
                center: location,
                zoom: 15
            });

            var marker = new google.maps.Marker({
                position: location,
                map: map,
                title: '내 위치',
                icon: {
                    url: "./file/내위치.png", // 마커로 사용할 이미지 URL
                    scaledSize: new google.maps.Size(40, 40), // 마커의 크기 (원하는 크기로 조절)
                    origin: new google.maps.Point(0, 0), // 이미지의 원점
                    anchor: new google.maps.Point(20, 40) // 마커 위치의 앵커 포인트 (마커의 '꼭지점')
                }
            });
        }

        function updateMap(lat, lng) {
            var newCenter = new google.maps.LatLng(lat, lng);
            map.setCenter(newCenter);

            var marker = new google.maps.Marker({
                position: newCenter,
                map: map,
                title: '내 위치',
                icon: {
                    url: "./file/내위치.png", // 마커로 사용할 이미지 URL
                    scaledSize: new google.maps.Size(40, 40), // 마커의 크기 (원하는 크기로 조절)
                    origin: new google.maps.Point(0, 0), // 이미지의 원점
                    anchor: new google.maps.Point(20, 40) // 마커 위치의 앵커 포인트 (마커의 '꼭지점')
                }
            });
        }

        function searchNearby(lat, lng) {
            var location = new google.maps.LatLng(lat, lng);

            var request = {
                location: location,
                radius: '1000', // 1km 반경 내에서 검색
                type: ['tourist_attraction', 'restaurant', 'cafe'] // 검색할 장소 타입
            };

            service = new google.maps.places.PlacesService(map);
            service.nearbySearch(request, function(results, status) {
                if (status === google.maps.places.PlacesServiceStatus.OK) {
                    displayPlaces(results);
                }
            });
        }

        function displayPlaces(places) {
            var placesList = document.getElementById('places');
            placesList.innerHTML = ''; // 기존 내용 초기화

            for (var i = 0; i < places.length; i++) {
                var place = places[i];

                // 장소 카드 생성
                var placeCard = document.createElement('div');
                placeCard.className = 'place-card';

                // 장소 이름
                var placeName = document.createElement('div');
                placeName.className = 'place-name';
                placeName.textContent = place.name;
                placeCard.appendChild(placeName);

                // 장소 주소
                var placeAddress = document.createElement('div');
                placeAddress.className = 'place-address';
                placeAddress.textContent = '주소: ' + place.vicinity;
                placeCard.appendChild(placeAddress);

                // 장소 평점
                var placeRating = document.createElement('div');
                placeRating.className = 'place-rating';
                placeRating.textContent = '평점: ' + (place.rating || 'N/A');
                placeCard.appendChild(placeRating);

                // 장소 카드 리스트에 추가
                placesList.appendChild(placeCard);

                // 지도에 마커 추가
                var marker = new google.maps.Marker({
                    position: place.geometry.location,
                    map: map,
                    title: place.name
                });
            }
        }
    </script>

    <!-- Google Maps 및 Places API 추가 -->
    <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCkMKSuFICn4ZYgCu-u50vBYzXmLSj8Tuo&libraries=places"></script>

</body>
</html>
