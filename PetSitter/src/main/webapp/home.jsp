<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.spring.petsitter.*" %>
<%@ page import="java.util.*" %>
<%
	// 가장 최근에 가입한 펫시터
	ArrayList<PetsitterVO> petsitter_list_date = (ArrayList<PetsitterVO>)request.getAttribute("petsitter_list_date");
	
	// 이달의 펫시터
	PetsitterVO petsitter_this_month = (PetsitterVO)request.getAttribute("petsitter_this_month");
	
	// 이달의 평점왕
	PetsitterVO petsitter_this_month_score = (PetsitterVO)request.getAttribute("petsitter_this_month_score");
	
	// 이달의 실적왕
	PetsitterVO petsitter_this_month_count = (PetsitterVO)request.getAttribute("petsitter_this_month_count");
	
	// 펫시터 목록
	ArrayList<PetsitterVO> list = (ArrayList<PetsitterVO>)request.getAttribute("list");
%>
<!doctype html>
<html lang="en">

<style>
.map_wrap {position:absolute;top:10px;left:10px;overflow:hidden;width:310px;z-index:2;height:100%;max-height:410px;margin:0;padding:0;}
.radius_border{border-radius:8px;z-index:1;}     
.custom_typecontrol {position:absolute;top:10px;left:10px;overflow:hidden;margin:0;padding:0;z-index:1;font-size:12px;color:white;z-index:1;}
  #div_output::-webkit-scrollbar {
    width: 10px;
  }
  #div_output::-webkit-scrollbar-thumb {
    background-color: #26bd72;
    border-radius: 10px;
  }
  #div_output::-webkit-scrollbar-track {
    background-color: white;
    border-radius: 10px;
    box-shadow: inset 0px 0px 5px white;
  }
   .pbtn01 {
   background:#53dc98!important;
   color : white!important;
   border : 1px solid #53DC98!important;
   }   

   .pbtn02 {
   background:#e67e22;
   color : white;
   margin : 0 0 0 5px;
   border : 1px solid #e67e22;
   }      
   
   .pbtn02:hover {
   color : #e67e22!important;
   background : white;
   }
   
   .pbtn01:hover {
   color : #53dc98!important;
   font-weight : bold;
   background : white!important;
   }   
   
#output{
    border: 1px solid white;
    border-collapse: collapse;
    width: 100%;
}
#output:hover{
	background-color : #26bd72;
}
.ftco-cover-2 {
  background-size: cover;
  background-position: center center;
  background-repeat: no-repeat;
  position: relative;
  overflow: hidden; }
  .ftco-cover-2, .ftco-cover-2 .container > .row {
    height: 80vh;
    }
  .ftco-cover-2 > .container {
    position: relative; }
  .ftco-cover-2.overlay2 {
    position: relative; }
    .ftco-cover-2.overlay2:before {
      content: "";
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      opacity: .15;
      background: rgba(55,122,255,0)!important;
      background: -moz-linear-gradient(45deg, #377aff 0%, #00d9ff 100%);
      background: -webkit-gradient(left bottom, right top, color-stop(0%, #377aff), color-stop(100%, #00d9ff));
      background: -webkit-linear-gradient(45deg, #377aff 0%, #00d9ff 100%);
      background: -o-linear-gradient(45deg, #377aff 0%, #00d9ff 100%);
      background: -ms-linear-gradient(45deg, #377aff 0%, #00d9ff 100%);
      background: linear-gradient(45deg, #377aff 0%, #00d9ff 100%);
      filter: progid:DXImageTransform.Microsoft.gradient( startColorstr='#377aff', endColorstr='#00d9ff', GradientType=1); }
    .ftco-cover-2.overlay2 h1 {
      color: #fff; }
    .ftco-cover-2.overlay2 p {
      color: #fff; }
      .ftco-cover-2.overlay2 p a {
        color: #fff;
        text-decoration: underline;
        font-weight: 700; }
        .ftco-cover-2.overlay2 p a:hover {
          text-decoration: none; }
    .ftco-cover-2.overlay2 form .form-control,
    .ftco-cover-2.overlay2 form .btn {
      height: 55px;
      border-radius: 4px; }
    .ftco-cover-2.overlay2 form .form-control {
      padding-left: 20px;
      padding-right: 20px;
      border-color: transparent;
      margin-right: 10px; }
    .ftco-cover-2.overlay2 form .btn {
      border-color: transparent; }
   


#main-circle{
background-color:black; 
width : 400px; 
height : 400px; 
margin-right:50px;
border-radius:400px

}

	a#MOVE_TOP_BTN {
   	/* position : 화면에 고정
		right, bottom : 버튼의 위치 설정
		display : 화면에서 숨김
		z-index : 다른 태그들보다 위로 오도록 설정(z-index 가 설정된 다른 태그가 있다면 그 태그보다 커야 함)
		*/
		background: rgb(83, 220, 152);
		color : white;
		width : 90px;
		height : 40px;
    position: fixed; 
    padding : 7px 0 0 30.8px;
    border-radius : 22px;
    right: 2%;
    bottom: 50px;
    display: none;
    z-index: 999;
	}

#petsitter_list{
	position : absolute;
	left: 500px;
	top: 1500px;
	background-color : #888888;
	width : 100px;
	height: 100px;
	z-index : 100;
}
</style>

  <head>
    <title>보살펴조</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    

    <link href="https://fonts.googleapis.com/css?family=Raleway:300,400,700&display=swap" rel="stylesheet">
	<!-- 아이콘 css -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fonts/icomoon/style.css">
    
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/owl.carousel.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/owl.theme.default.min.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/fonts/flaticon/font/flaticon.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/aos.css">

    <!-- MAIN CSS 다양한 폰트크기보유 -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/style.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/petsitter-style.css">
  </head>
  
<style>
	.dropdown:hover {
		background-color: rgb(83, 220, 153);
	}
	
	.dropdown:active {
		background-color: rgb(83, 220, 153);
	}
	.btn-secondary {
		background-color: rgb(83, 220, 153);
		border-color: rgb(83, 220, 153);
		vertical-align: baseline;
		font-weight: bold;
	}
	
	.btn-secondary:hover {
		background-color: rgb(83, 220, 153);
		border-color: rgb(83, 220, 153);
	}
	
	.btn-secondary:active {
		background-color: rgb(83, 220, 153);
		border-color: rgb(83, 220, 153);
	}
	
	.btn-secondary:focus {
		background-color: rgb(83, 220, 153);
		border-color: rgb(83, 220, 153);
		box-shadow: 0 0 0 0 rgb(83, 220, 153);
	}
	
	.dropdown-menu {
		min-width: 60px !important;
	}

	.dropdown-item:hover {
		background-color: rgb(83, 220, 153);
		color: rgb(255, 255, 255) !important;
	}
	
	.dropdown-item {
		 color: #53dc99 !important;
		 font-weight: bold;
	}
	
	.main-menu li a {
		font-weight: bold;
	}
</style>

<body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">

<div class="site-wrap" id="home-section">

      <div class="site-mobile-menu site-navbar-target">
        <div class="site-mobile-menu-header">
          <div class="site-mobile-menu-close mt-3">
            <span class="icon-close2 js-menu-toggle"></span>
          </div>
        </div>
        <div class="site-mobile-menu-body"></div>
      </div>

      <div class="top-bar">
        <div class="container">
          <div class="row">
            <div class="col-12">
              <a href="#" class=""><span class="mr-2  icon-envelope-open-o"></span> <span class="d-none d-md-inline-block">petsitter@naver.com</span></a>
              <span class="mx-md-2 d-inline-block"></span>
              <a href="#" class=""><span class="mr-2  icon-phone"></span> <span class="d-none d-md-inline-block">(02).2010.1010</span></a>

              <div class="float-right" style="margin-bottom:8px;">
              	<%
              		if(session.getAttribute("id") == "" || session.getAttribute("id") == null) {
              	%>
                <a href="loginform.me" ><span class = "font-size-14" >로그인 &amp; 회원가입</span></a>
                <span class="mx-md-2 d-inline-block"></span>
                <%} else if(((String)session.getAttribute("id")).contains("@")){ %> <!-- 일반 회원 마이 페이지 -->
                <a href="memberinfo.me?id=${id}"><span class="font-size-14" >${name }님</span></a>&nbsp;&nbsp;&nbsp;
                <a href="logout.me"><span class="font-size-14">로그아웃</span></a>
                <%} else {%> <!-- 펫시터 마이 페이지 -->
                <a href="petsitterinfo.me"><span class="font-size-14" >${name }님</span></a>&nbsp;&nbsp;&nbsp;
                <a href="logout.me"><span class="font-size-14">로그아웃</span></a>
                <%} %>
                </div>
            </div>
          </div>
        </div>
      </div>
      <header class="site-navbar js-sticky-header site-navbar-target" role="banner" style = "background : rgb(83,220,152);">
        <div class="container" >
          <div class="row align-items-center position-relative" >
            <div class="site-logo">
              <a href="home.me" ><span class="main_whitefont">보살펴조</span></a>
            </div>

	            <div class="col-12">
	              <nav class="site-navigation text-right ml-auto " role="navigation" >
	                <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">
	                	<li class="dropdown" onmousedown="this.style.backgroundColor='rgb(83, 220, 153)'">
										  <button class="btn btn-secondary" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
												돌봄
										  </button>
										  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" >
										    <a href="reservation2.br" class="dropdown-item" style="font-size:15px;">방문 돌봄</a>
	                  		<a href="reservation1.br" class="dropdown-item" style="font-size:15px;" >위탁 돌봄</a>
										  </div>
										</li>
										<li class="dropdown">
										  <button class="btn btn-secondary" type="button" id="dropdownMenuButton" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" >
												게시판
										  </button>
										  <div class="dropdown-menu" aria-labelledby="dropdownMenuButton" >
										    <a href="proboard.bo" class="dropdown-item" style="font-size:15px;" >전문가 상담 게시판</a>
	                  		<a href="mboardlist.me" class="dropdown-item" style="font-size:15px;" >회원 게시판</a>
	                  		<a href="pqboardlist.me" class="dropdown-item" style="font-size:15px;" >펫시터 게시판</a>
										  </div>
										</li>
	                  <li><a href="review_board.bo" class="nav-link" id="main_whitefont2" style = "font-size:15px">이용 후기</a></li>
	                  <li><a href="home.me" class="nav-link" id="main_whitefont2" style = "font-size:15px">공지사항</a></li> 
	                </ul>
	              </nav>
	            </div>
            
            <div class="toggle-button d-inline-block d-lg-none"><a href="#" class="site-menu-toggle py-5 js-menu-toggle text-black"><span class="icon-menu h3"></span></a></div>
          </div>
        </div>
        <!-- 스크롤 위로올라가기 버튼 html-->
        <a id="MOVE_TOP_BTN" href="#">TOP</a>
      </header>
		

<!-- 강아지 이미지 메인 시작 -->	
<div style = "height : 960px;">
<div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
	

  
  <div class="carousel-inner">
    <div class="carousel-item active" style = "background : rgba(254,175,18,0.2); height : 960px;">
    
	    <div class="ftco-blocks-cover-1">
			  <div class="container">
			    <div class = "row">
	        	<div class="col-md-7 ftco-cover-2 overlay2" style="background-image: url('resources/images/maindog2.png');"></div>
	    	      <div class="col-md-5">
	    	        	<img src ="resources/images/dogmark.png"  width = "110px" height = "80px" style = "margin-top : 50%; margin-left:36%; opacity: 0.7;" />
	    	        		
	    	        	<div class="col-12 font-size-14 text-center" id="main_grayfont2">주거하는 곳을 입력하시면 가까운 펫시터를 연결해드립니다!</div>
	                <p/>
	                <p class="col-12 font-size-14 text-center" style = " color : orange!important;">반경 5km내에 펫시터 정보를 알 수 있습니다.</p>
	                <form action="#">
	                <div class="form-group d-flex">
	                	<input class="form-control" type="text"  id="sample5_address"  placeholder="주소를 입력하세요" >
	                  <input type="button" class="btn btn-outline-warning px-4" onclick="sample5_execDaumPostcode(); location.href='#mapgo';" value="주소 검색 " >
	                </div>
	                </form>
	                
	             
	    	      </div>
	    	    </div>
	    	  </div>
	      </div>
		</div>
		
		<div class="carousel-item" style = "background : rgba(209,192,191,1); height : 960px;">
	    <div class="ftco-blocks-cover-1">
			  <div class="container">
			    <div class = "row">
	        	<div class="col-md-7 ftco-cover-2 overlay2" style="background-image: url('resources/images/maindog3.png');"></div>
	    	      <div class="col-md-5">
	    	       			<a href = "#"><p class="col-16 font-size-20 text-center" style = "margin-top : 48%; font-weight : bold; color :  rgba(240,86,30);important;">공지사항 바로가기!</p></a>
										<div class="col-12 font-size-14 text-center font-gray-8" id="" style = "font-weight : bold;">코로나 안전수칙 철저하게 지켜드립니다.</div>
	                  <p/>
	                  <div style = "background : #a0a0a0; border-radius : 10px 10px 50px 10px; width : 100%; height : 220px; margin-left:2%;">
	                    <br/>
	                    <a href = "#">
	                    	<p class="col-12 font-size-20 text-center" style = "font-weight : bold; color : orange!important;">공지사항 : 코로나 관련 규칙 조항.</p>
	                   	  <p class="col-12 font-size-14 text-center" style = " color : white!important;">1.마스크 착용 근무 실시.</p>
	                   		<p class="col-12 font-size-14 text-center" style = " color : white!important;">2.틈틈히 바른 손씻기 및 손세정제 사용.</p>
	                   		<p class="col-12 font-size-14 text-center" style = " color : white!important;">3.감기증상이 있을시 예약 중지 및 조치.</p>
	                    </a>
	                  </div>
	               
	    	      </div>
	    	    </div>
	    	  </div>
	      </div>
		</div>

</div>
	</div>
	
	<a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
    <span  aria-hidden="true">
    	<img  src="resources/images/leftarrow.png" width = "35px" height = "60px"></img>
    </span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
    <span aria-hidden="true">
    	<img  src="resources/images/rightarrow.png" width = "35px" height = "60px"></img>
    </span>
    <span class="sr-only">Next</span>
  </a>
</div>	

<!-- 강아지 이미지 메인 종료-->

</div>
      	<div id ="mapgo" style = "width : 200px; height : 1px;"></div>       
        <div style = "width : 200px; height : 20px;"></div>
<br/><br/>     
         <!-- Map -->
		
         <div id="map" style="margin:0 auto; text-align:center; width:1110px;height:500px;display:none;position:relative;overflow:hidden;"><div class="map_wrap">
         <div id = "div_output" class="custom_typecontrol radius_border" style = "width : 300px; max-height:400px; background-color:rgb(83, 220, 152); overflow:auto">
    </div>
         </div>
         
    </div>
         

         
         
</div>
        <!-- END .ftco-cover-1 -->
<!-- 주소 입력 -->
  <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=24e91ec8fe5a3a10070597915f67d6ba&libraries=services"></script>

<script>
	

var geocoder = new kakao.maps.services.Geocoder();
var addrX = new Array();
var addrY = new Array();
var title = new Array();
var latlng1 = new Array();
var nickname = new Array();
var addr1 = new Array();
var count = new Array();
var score = new Array();
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
<%for(int i = 0; i < list.size(); i++){%>
addrX.push(<%=list.get(i).getPETSITTER_ADDRX()%>);
addrY.push(<%=list.get(i).getPETSITTER_ADDRY()%>);
title.push('<%=list.get(i).getPETSITTER_ID()%>');
<%
}
%>

<%for(int i = 0; i < list.size(); i++){%>
latlng1.push(new kakao.maps.LatLng(addrY[<%=i%>],addrX[<%=i%>]));
nickname.push('<%=list.get(i).getPETSITTER_NICKNAME()%>');
addr1.push('<%=list.get(i).getPETSITTER_ADDRESS().split(",")[1]%>');
count.push(<%=list.get(i).getPETSITTER_COUNT()%>);
score.push(<%=list.get(i).getPETSITTER_SCORE()%>);
<%
}
%>
var circle;
var callback = function(result, status) {
    if (status === kakao.maps.services.Status.OK) {
    	var coords = new kakao.maps.LatLng(result[0].x, result[0].y);
    }
};


    var mapContainer = document.getElementById('map'), // 지도를 표시할 div
        mapOption = {
            center: new daum.maps.LatLng(37.537187, 127.005476), // 지도의 중심좌표
            level: 8 // 지도의 확대 레벨
        };

    //지도를 미리 생성
    var map = new daum.maps.Map(mapContainer, mapOption); //
    //주소-좌표 변환 객체를 생성
    var geocoder = new daum.maps.services.Geocoder();
    //마커를 미리 생성
    var marker = new daum.maps.Marker({
        position: new daum.maps.LatLng(37.537187, 127.005476),
        map: map
    });
    var output = '<table></table>';
    var radius = 6000; //제한할 반경(m)
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수
                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
                // 주소로 상세 정보를 검색
                geocoder.addressSearch(data.address, function(results, status) { //
                    // 정상적으로 검색이 완료됐으면
                    if (status === daum.maps.services.Status.OK) {
                    	
                        var result = results[0]; //첫번째 결과의 값을 활용
                        // 해당 주소에 대한 좌표를 받아서
                        var coords = new daum.maps.LatLng(result.y, result.x);
                        if(circle){
                        	circle.setMap(null);
                        }
                        
                        circle = new kakao.maps.Circle({
                            center : coords,  // 원의 중심좌표 입니다 
                            radius: radius, // 미터 단위의 원의 반지름입니다 
                            strokeWeight: 5, // 선의 두께입니다 
                            strokeColor: '#75B8FA', // 선의 색깔입니다
                            strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
                            strokeStyle: 'dashed', // 선의 스타일 입니다
                            fillColor: '#CFE7FF', // 채우기 색깔입니다
                            fillOpacity: 0.7  // 채우기 불투명도 입니다   
                        }); 
                        
                        // 지도를 보여준다.
                        mapContainer.style.display = "block";
                        map.relayout();
                        // 지도 중심을 변경한다.
                        map.setCenter(coords);
                        marker.setPosition(coords);
                        
                        circle.setMap(map); 

						
						$('#div_output').empty();
						output ='<input type=button class = "btn btn-sm pbtn01" onclick="button1_click();" value= "평점 순"> &nbsp;&nbsp;&nbsp;&nbsp;<input type=button class = "btn btn-sm pbtn01" onclick="button2_click();" value= "거리 순">';
						var listcount = 0;
                         for (var i = 0; i < addrX.length; i ++) {
                            
                            // 마커 이미지의 이미지 크기 입니다
                            var imageSize = new kakao.maps.Size(24, 35); 
                            
                            // 마커 이미지를 생성합니다    
                            var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
                            
                            // 마커를 생성합니다
/*                              var marker1 = new kakao.maps.Marker({
                                map: map, // 마커를 표시할 지도
                                position: latlng1[i], // 마커를 표시할 위치
                            });
 */
                            var c1 = map.getCenter(); //중심점 좌표
                            var c2 = latlng1[i]; //마커의 좌표
                            var poly = new kakao.maps.Polyline({ //선을 그리는 함수
                            	path:[c1, c2]
                            });
                            var addrLength; //거리를 추출해 저장할 변수
                            var lengthKm; //거리의 단위
                            var dist = poly.getLength(); //두 좌표사이의 거리를 반환 (m)
                            if(dist < 1000){
                            	addrLength = dist.toFixed(0);
                            	lengthKm = 'M';
                            }else{
                            	addrLength = (dist/1000).toFixed(1);
                            	lengthKm = 'KM';
                            }
                            if(dist < radius){
                            output += '<table id="output">';
							output += '<tr><th>닉네임</th><th>'+nickname[i]+'</th></tr>';
							output += '<tr><th>주소</th><th>'+addr1[i]+'</th></tr>';
							output += '<tr><th>거리</th><th>'+addrLength+'('+lengthKm+')</th></tr>';
							output += '<tr><th>평점</th><th>'+score[i]+'</th></tr>';
							output += '</table>';
							listcount = 1;
                            }else{
                            }
                        }
                         if(listcount==0){
                        	 output = '<b style="font-size: 20px">주변 펫시터가 없습니다 </b>'
                        	$('#div_output').append(output);
                         }else{
                        	 $('#div_output').append(output);
                         }
                        
                        
                    }
                });
            }
        }).open();
    }
    
    function button1_click() {
    	<%PetsitterVO voList[] = new PetsitterVO[list.size()];
    		for(int i = 0;i < list.size();i++){
    			voList[i] = list.get(i);
    		}
    	%>
    	
    	<%PetsitterVO vo = new PetsitterVO();
    	for(int i = 0; i < voList.length-1; i++){
    		for(int j = i + 1; j <voList.length; j++){
    			if(voList[i].getPETSITTER_SCORE() < voList[j].getPETSITTER_SCORE()){
    				vo = voList[i];
    				voList[i] = voList[j];
    				voList[j] = vo;
    			}
    		}
    	}%>
    	latlng1.length = 0;
    	nickname.length = 0;
    	addr1.length = 0;
    	count.length = 0;
    	score.length = 0;
		<%
		
		for(int i =0; i < voList.length; i ++){%>
		latlng1.push(new kakao.maps.LatLng(<%=voList[i].getPETSITTER_ADDRY()%>,<%=voList[i].getPETSITTER_ADDRX()%>));
		nickname.push('<%=voList[i].getPETSITTER_NICKNAME()%>');
		addr1.push('<%=voList[i].getPETSITTER_ADDRESS().split(",")[1]%>');
		count.push(<%=voList[i].getPETSITTER_COUNT()%>);
		score.push(<%=voList[i].getPETSITTER_SCORE()%>);
		<%
		}
		%>
    	$('#div_output').empty();
		output ='<input type=button class = "btn btn-sm pbtn01" onclick="button1_click();" value= "평점 순"> &nbsp;&nbsp;&nbsp;&nbsp;<input type=button class = "btn btn-sm pbtn01" onclick="button2_click();" value= "거리 순">';
    	for(var i = 0; i < addrX.length; i++){
    		var c1 = map.getCenter(); //중심점 좌표
            var c2 = latlng1[i]; //마커의 좌표

            var poly = new kakao.maps.Polyline({ //선을 그리는 함수
            	path:[c1, c2]
            });
            var addrLength; //거리를 추출해 저장할 변수
            var lengthKm; //거리의 단위
            var dist = poly.getLength(); //두 좌표사이의 거리를 반환 (m)
            if(dist < 1000){
            	addrLength = dist.toFixed(0);
            	lengthKm = 'M';
            }else{
            	addrLength = (dist/1000).toFixed(1);
            	lengthKm = 'KM';
            }
            if(dist < radius){
            output += '<table id="output">';
			output += '<tr><th>닉네임</th><th>'+nickname[i]+'</th></tr>';
			output += '<tr><th>주소</th><th>'+addr1[i]+'</th></tr>';
			output += '<tr><th>거리</th><th>'+addrLength+'('+lengthKm+')</th></tr>';
			output += '<tr><th>평점</th><th>'+score[i]+'</th></tr>';
			output += '</table>';
			
            }else{
            }
    	}
    	$('#div_output').append(output);
    }
    
    function button2_click(){
    	<%PetsitterVO voList1[] = new PetsitterVO[list.size()];
		for(int i = 0;i < list.size();i++){
			voList1[i] = list.get(i);
		}
	%>
	
	<%PetsitterVO vo1 = new PetsitterVO();%>
	latlng1.length = 0;
	nickname.length = 0;
	addr1.length = 0;
	count.length = 0;
	score.length = 0;
	<%
	
	for(int i =0; i < voList1.length; i ++){%>
	latlng1.push(new kakao.maps.LatLng(<%=voList1[i].getPETSITTER_ADDRY()%>,<%=voList1[i].getPETSITTER_ADDRX()%>));
	nickname.push('<%=voList1[i].getPETSITTER_NICKNAME()%>');
	addr1.push('<%=voList1[i].getPETSITTER_ADDRESS().split(",")[1]%>');
	count.push(<%=voList1[i].getPETSITTER_COUNT()%>);
	score.push(<%=voList1[i].getPETSITTER_SCORE()%>);
	<%
	}
	%>
	
	var polyLine = new Array();
	var Line;
	
	
	<% double line[] = new double[voList1.length];%>
	for(var i = 0; i < addrX.length; i++){
		var c1 = map.getCenter();
		var c2 = latlng1[i];
		var poly = new kakao.maps.Polyline({
			path:[c1,c2]
		});
		polyLine[i] = poly.getLength();
	}
 
	jQuery.ajaxSettings.traditional = true;

	$.ajax({
		url:'/petsitter/map_addr.bo',
		type : 'POST',
		dataType : "json",
		data : {"polyLine":polyLine},
		contentType : 'application/x-www-form-urlencoded; charset=utf-8',
		success:function(data){
			latlng1.length = 0;
			nickname.length = 0;
			addr1.length = 0;
			count.length = 0;
			score.length = 0;
			$.each(data,function(index, item){
				latlng1.push(new kakao.maps.LatLng(item.petsitter_ADDRY,item.petsitter_ADDRX));
				nickname.push(item.petsitter_NICKNAME);
				addr1.push(item.petsitter_ADDRESS.split(",")[1]);
				count.push(item.petsitter_COUNT);
				score.push(item.petsitter_SCORE);
			});
			$('#div_output').empty();
			output ='<input type=button class = "btn btn-sm pbtn01" onclick="button1_click();" value= "평점 순"> &nbsp;&nbsp;&nbsp;&nbsp;<input type=button class = "btn btn-sm pbtn01" onclick="button2_click();" value= "거리 순">';
			for(var i = 0; i < addrX.length; i++){
				var c1 = map.getCenter(); //중심점 좌표
		        var c2 = latlng1[i]; //마커의 좌표
				
		        var poly = new kakao.maps.Polyline({ //선을 그리는 함수
		        	path:[c1, c2]
		        });
		        var addrLength; //거리를 추출해 저장할 변수
		        var lengthKm; //거리의 단위
		        var dist = poly.getLength(); //두 좌표사이의 거리를 반환 (m)
		        
		        if(dist < 1000){
		        	addrLength = dist.toFixed(0);
		        	lengthKm = 'M';
		        }else{
		        	addrLength = (dist/1000).toFixed(1);
		        	lengthKm = 'KM';
		        }
		        if(dist < radius){
		        output += '<table id="output">';
				output += '<tr><th>닉네임</th><th>'+nickname[i]+'</th></tr>';
				output += '<tr><th>주소</th><th>'+addr1[i]+'</th></tr>';
				output += '<tr><th>거리</th><th>'+addrLength+'('+lengthKm+')</th></tr>';
				output += '<tr><th>평점</th><th>'+score[i]+'</th></tr>';
				output += '</table>';
				
		        }else{
		        }
			}
			$('#div_output').append(output);
		},
		error:function(){
	        alert("list ajax통신 실패!!!");
	    }
	});
	
	

	
	

    }
</script>



<!-- 소개부분 시작 -->
<div class="block__73694 site-section border-top  id="why-us-section" style = "margin : 25px 0 0 0;">
        <div class="container">
          <div class="row d-flex no-gutters align-items-stretch">

            <div class="col-12 col-lg-6 block__73422 order-lg-2" style="background-image: url('resources/images/dog02.jpg');" data-aos="fade-left" data-aos-delay=""></div>
            <div class="col-lg-6 mr-auto p-lg-5 mt-4 mt-lg-0 order-lg-1" data-aos="fade-right" data-aos-delay="">
              <h2 class="mb-4 main_mintfont" style = "font-weight : bold">보살펴조</h2>
              <p class = "text-center main_mintfont" style="font-weight : bold;">저희 보살펴조에서는 신뢰있는 서비스를 위해 펫시터를 선별 및 지원하고 있습니다. 아래 조건들을 약속하겠습니다!</p>

              <ul class="ul-check primary list-unstyled mt-5 font-size-14 text-center">
                <li>보살펴조만의 애완동물 보험제도를 제공합니다.</li>
                <p/>
                <li>자격증을 소유한 펫시터를 선별합니다.</li>
                <p/>
                <li>펫시터의 발전을 위해 1년의 한번 프로그램을 수료해야합니다.</li>
                <p/>
                <li>애완동물은 코로나19의  전염성이거의 없지만 보살펴조만의 여러 조항으로 예방에 힘을 씁니다.</li>
                <p/>
                <li>약 복용법 및 의료 기기 사용법을 숙지합니다.</li>
              </ul>
            </div>
          </div>
        </div>
</div>


<!-- 소개부분 종료 -->



<!-- 게시판 목록부분 시작 -->
<div class="site-section bg-light">
	<div class="container">
		<div class="row mb-6 justify-content-center">
			<div class="col-md-6 text-center">
				<div class="block-heading-1" data-aos="fade-up" data-aos-delay="">
					<h1 style = "background: rgba(83,220,152,0.86); color : white; border-radius : 10px 10px 3px 3px">main service</h1>
					<p>보살펴조 플랫폼 주 컨텐츠입니다. 필요한 서비스를 선택하세요!</p>
				</div>
			</div>
		</div>
	</div>
</div>
		   
        <div class=" ftco-service-image-1 pb-5 bg-light">
          <div class="container">
            <div class="owl-carousel owl-all">
              <div class="service text-center">
                <a href="#"><img src="resources/images/petsitter-find.jpg" alt="Image" class="img-fluid"></a>
                <div class="px-md-3">
                  <h3><a href="#" style = "color : rgba(83,220,152)!important; font-weight : bold; " >펫시터 찾기</a></h3>
                  <p style = "font-size:14px;">고객과 가깝고 적합한 펫시터를 찾을 수 있어요!</p>
                </div>
              </div>
              <div class="service text-center">
                <a href="#"><img src="resources/images/dog-doctor.png" alt="Image" class="img-fluid"></a>
                <div class="px-md-3">
                  <h3><a href="#" style = "color : rgba(83,220,152)!important; font-weight : bold;" >반려동물 전문가 상담</a></h3>
                  <p style = "font-size:14px;">전문적인 수의사, 훈련사 님들이 실시간으로 상담해주는 커뮤니티 공간입니다!</p>
                  
                </div>
              </div>
              <div class="service text-center">
                <a href="#"><img src="resources/images/petsitter-com.jpg" alt="Image" class="img-fluid"></a>
                <div class="px-md-3">
                  <h3><a href="#" style = "color : rgba(83,220,152)!important; font-weight : bold;" >생생한 펫시터 이용후기</a></h3>
                  <p style = "font-size:14px;">솔직하고 담백한 실시간 이용후기!</p>
                </div>
              </div>
            </div>
          </div>
        </div>
<!-- 게시판 목록부분 끝 -->

<!-- 이달의 추천 펫시터 부분 시작 -->
		<div class="site-section" id="team-section" style ="height : 1080px;">
        <div class="container">
          <div class="row mb-5 justify-content-center">
            <div class="col-md-7 text-center">
              <div class="block-heading-1" data-aos="fade-up" data-aos-delay="">
                <h1 class="main_violetfont2" style = "border-bottom:thick double;">이달의 펫시터 추천</h1>
                <p>달마다 신뢰가는 펫시터분들을 추천 해드립니다. 가까운 펫시터분이있는지 확인해보세요!</p>
              </div>
            </div>
          </div>
          
          <%
          	PetsitterVO petsitter_date1 = null;
          	PetsitterVO petsitter_date2 = null;
          	PetsitterVO petsitter_date3 = null;
          	if(petsitter_list_date.size() == 1) {
	          	petsitter_date1 = petsitter_list_date.get(0);
          	} else if(petsitter_list_date.size() == 2) {
          		petsitter_date1 = petsitter_list_date.get(0);
	          	petsitter_date2 = petsitter_list_date.get(1);
          	} else if(petsitter_list_date.size() == 3) {
          		petsitter_date1 = petsitter_list_date.get(0);
	          	petsitter_date2 = petsitter_list_date.get(1);
	          	petsitter_date3 = petsitter_list_date.get(2);
          	}
          %>
          <div class="owl-carousel owl-all mb-5">
            <div class="block-team-member-1 text-center rounded h-100">
              <figure>
               <a href="#">
               <%
               		if(petsitter_date1 == null) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               </figure>
	             <a href="#"><h3 class="font-size-20 text-black">펫시터</h3></a>
	             <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3">펫시터</span>
	             <a href="#"><p class="mb-4" style = "color : #949494!important;">펫시터</p></a>
	             <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">신규 추천 펫시터</div>
               <%
               		} else {
               %>
               <%
               			if(petsitter_date1.getPETSITTER_PHOTO_PROFILE_FILE().equals("N")) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			} else {
               %>
               <img src="/filepath/<%=petsitter_date1.getPETSITTER_PHOTO_PROFILE_FILE() %>" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			}
               %>
              </figure>
              <a href="#"><h3 class="font-size-20 text-black"><%=petsitter_date1.getPETSITTER_NAME() %></h3></a>
              <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3"><%=petsitter_date1.getPETSITTER_ADDRESS() %></span>
              <a href="#"><p class="mb-4" style = "color : #949494!important;"><%=petsitter_date1.getPETSITTER_INTRODUCE() %></p></a>
              <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">신규 추천 펫시터</div>
              <%
               		}
              %>
            </div>
            
            <div class="block-team-member-1 text-center rounded h-100">
              <figure>
               <a href="#">
               <%
               		if(petsitter_date2 == null) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               </figure>
	             <a href="#"><h3 class="font-size-20 text-black">펫시터</h3></a>
	             <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3">펫시터</span>
	             <a href="#"><p class="mb-4" style = "color : #949494!important;">펫시터</p></a>
	             <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">신규 추천 펫시터</div>
               <%
               		} else {
               %>
               <%
               			if(petsitter_date2.getPETSITTER_PHOTO_PROFILE_FILE().equals("N")) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			} else {
               %>
               <img src="/filepath/<%=petsitter_date2.getPETSITTER_PHOTO_PROFILE_FILE() %>" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			}
               %>
              </figure>
              <a href="#"><h3 class="font-size-20 text-black"><%=petsitter_date2.getPETSITTER_NAME() %></h3></a>
              <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3"><%=petsitter_date2.getPETSITTER_ADDRESS() %></span>
              <a href="#"><p class="mb-4" style = "color : #949494!important;"><%=petsitter_date2.getPETSITTER_INTRODUCE() %></p></a>
              <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">신규 추천 펫시터</div>
              <%
               		}
              %>
            </div>

            <div class="block-team-member-1 text-center rounded h-100">
              <figure>
               <a href="#">
               <%
               		if(petsitter_date3 == null) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               </figure>
	             <a href="#"><h3 class="font-size-20 text-black">펫시터</h3></a>
	             <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3">펫시터</span>
	             <a href="#"><p class="mb-4" style = "color : #949494!important;">펫시터</p></a>
	             <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">신규 추천 펫시터</div>
               <%
               		} else {
               %>
               <%
               			if(petsitter_date3.getPETSITTER_PHOTO_PROFILE_FILE().equals("N")) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			} else {
               %>
               <img src="/filepath/<%=petsitter_date3.getPETSITTER_PHOTO_PROFILE_FILE() %>" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			}
               %>
              </figure>
              <a href="#"><h3 class="font-size-20 text-black"><%=petsitter_date3.getPETSITTER_NAME() %></h3></a>
              <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3"><%=petsitter_date3.getPETSITTER_ADDRESS() %></span>
              <a href="#"><p class="mb-4" style = "color : #949494!important;"><%=petsitter_date3.getPETSITTER_INTRODUCE() %></p></a>
              <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">신규 추천 펫시터</div>
              <%
               		}
              %>
            </div>

            <div class="block-team-member-1 text-center rounded h-100">
              <figure>
               <a href="#">
               <%
               		if(petsitter_this_month == null) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               </figure>
	             <a href="#"><h3 class="font-size-20 text-black">펫시터</h3></a>
	             <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3">펫시터</span>
	             <a href="#"><p class="mb-4" style = "color : #949494!important;">펫시터</p></a>
	             <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">이달의 펫시터</div>
               <%
               		} else {
               %>
               <%
               			if(petsitter_this_month.getPETSITTER_PHOTO_PROFILE_FILE().equals("N")) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			} else {
               %>
               <img src="/filepath/<%=petsitter_this_month.getPETSITTER_PHOTO_PROFILE_FILE() %>" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			}
               %>
              </figure>
              <a href="#"><h3 class="font-size-20 text-black"><%=petsitter_this_month.getPETSITTER_NAME() %></h3></a>
              <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3"><%=petsitter_this_month.getPETSITTER_ADDRESS() %></span>
              <a href="#"><p class="mb-4" style = "color : #949494!important;"><%=petsitter_this_month.getPETSITTER_INTRODUCE() %></p></a>
              <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">이달의 펫시터</div>
              <%
               		}
              %>
            </div>
            
            <div class="block-team-member-1 text-center rounded h-100">
              <figure>
               <a href="#">
               <%
               		if(petsitter_this_month_score == null) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               </figure>
	             <a href="#"><h3 class="font-size-20 text-black">펫시터</h3></a>
	             <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3">펫시터</span>
	             <a href="#"><p class="mb-4" style = "color : #949494!important;">펫시터</p></a>
	             <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">이달의 평점왕</div>
               <%
               		} else {
               %>
               <%
               			if(petsitter_this_month_score.getPETSITTER_PHOTO_PROFILE_FILE().equals("N")) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			} else {
               %>
               <img src="/filepath/<%=petsitter_this_month_score.getPETSITTER_PHOTO_PROFILE_FILE() %>" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			}
               %>
              </figure>
              <a href="#"><h3 class="font-size-20 text-black"><%=petsitter_this_month_score.getPETSITTER_NAME() %></h3></a>
              <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3"><%=petsitter_this_month_score.getPETSITTER_ADDRESS() %></span>
              <a href="#"><p class="mb-4" style = "color : #949494!important;"><%=petsitter_this_month_score.getPETSITTER_INTRODUCE() %></p></a>
              <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">이달의 평점왕</div>
              <%
               		}
              %>
            </div>
            
            <div class="block-team-member-1 text-center rounded h-100">
              <figure>
               <a href="#">
               <%
               		if(petsitter_this_month_count == null) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               </figure>
	             <a href="#"><h3 class="font-size-20 text-black">펫시터</h3></a>
	             <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3">펫시터</span>
	             <a href="#"><p class="mb-4" style = "color : #949494!important;">펫시터</p></a>
	             <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">이달의 실적왕</div>
               <%
               		} else {
               %>
               <%
               			if(petsitter_this_month_count.getPETSITTER_PHOTO_PROFILE_FILE().equals("N")) {
               %>
               <img src="resources/images/defaultprofile02.png" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			} else {
               %>
               <img src="/filepath/<%=petsitter_this_month_count.getPETSITTER_PHOTO_PROFILE_FILE() %>" alt="Image" class="img-fluid rounded-circle"></a>
               <%
               			}
               %>
              </figure>
              <a href="#"><h3 class="font-size-20 text-black"><%=petsitter_this_month_count.getPETSITTER_NAME() %></h3></a>
              <span class="d-block font-gray-9 letter-spacing-1 text-uppercase font-size-14 mb-3"><%=petsitter_this_month_count.getPETSITTER_ADDRESS() %></span>
              <a href="#"><p class="mb-4" style = "color : #949494!important;"><%=petsitter_this_month_count.getPETSITTER_INTRODUCE() %></p></a>
              <div class=" main_whitefont" style = "background : rgba(134,127,160); border-radius : 7px 7px 7px 7px">이달의 실적왕</div>
              <%
               		}
              %>
            </div>
            
          
            
            
            
        </div>
      </div>
    </div>
<!-- 추천 펫시터 부분 종료 -->


<!-- 영상부분 시작 -->
      <div class="site-section bg-light" id="about-section" style = "margin : 0 0 0 0">
 
        <div class="site-section" style = "padding : 50px;">
					<div class="container">
						<div class="row mb-6 justify-content-center">
							<div class="col-md-6 text-center">
								<div class="block-heading-1" data-aos="fade-up" data-aos-delay="">
									<h2 class="footer-heading" style = "background: rgba(83,220,152,0.86); color : white; border-radius : 10px 10px 3px 3px">About Us</h2>
									<h5>보살펴조 소개 영상입니다</h5>
								</div>
							</div>
						</div>
					</div>
				</div>

      </div>



      <div class="site-section bg-light" id="about-section" style ="height : 1000px;">
        <div class="container">
          <div class="row justify-content-center mb-4 block-img-video-1-wrap">
            <div class="col-md-12 mb-5">
              <figure class="block-img-video-1" data-aos="fade">
                <a href="https://www.youtube.com/watch?v=oXynEv6lYGE" data-fancybox data-ratio="2">
                <span class="icon"><span class="icon-play"></span></span>
                <img src="resources/images/petsitter-video.jpg" alt="Image" class="img-fluid">
              </a>
              </figure>
            </div>
          </div>
          <div class="row">
            <div class="col-12">
              <div class="row">
                <div class="col-6 col-md-6 mb-4 col-lg-0 col-lg-3" data-aos="fade-up" data-aos-delay="">
                  <div class="block-counter-1">
                    <span class="number main_mintfont"><span data-number="140">0</span>+</span>
                    <span class="caption">이달의 펫시터 연결</span>
                  </div>
                </div>
                <!-- data-number 부분에 DB로 업데이트 되게 설정 -->
                <div class="col-6 col-md-6 mb-4 col-lg-0 col-lg-3" data-aos="fade-up" data-aos-delay="100">
                  <div class="block-counter-1">
                    <span class="number main_mintfont"><span data-number="322">0</span>+</span>
                    <span class="caption">등록된 신뢰가는 펫시터</span>
                  </div>
                </div>
                <div class="col-6 col-md-6 mb-4 col-lg-0 col-lg-3" data-aos="fade-up" data-aos-delay="200">
                  <div class="block-counter-1">
                    <span class="number main_mintfont"><span data-number="1125">0</span>+</span>
                    <span class="caption">올해의 펫시터 연결</span>
                  </div>
                </div>
                <div class="col-6 col-md-6 mb-4 col-lg-0 col-lg-3" data-aos="fade-up" data-aos-delay="300">
                  <div class="block-counter-1">
                    <span class="number main_mintfont"><span data-number="1452">0</span>+</span>
                    <span class="caption">총 누적 펫시터 연결</span>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
<!-- 영상부분 종료 -->
      


	<!-- 하단 바 시작 -->
    <footer class="site-footer">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-7">
                <h2 class="footer-heading mb-4" id="main_grayfont1">About Us</h2>
                <p id="main_grayfont2" style = "font-size : 14px;">반려동물들을 위해 고객과 펫시터와를 연결시켜주는 매칭 플렛폼입니다. 신뢰와 안전을 위해 최선을 다하겠습니다.</p>
              </div>
              <div class="col-md-4 ml-auto">
                <h2 class="footer-heading mb-4" id="main_grayfont1">CONTANTS</h2>
                <ul class="list-unstyled">
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">방문 돌봄</a></li>
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">위탁 돌봄</a></li>
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">반려동물 전문가 상담</a></li>
                  <li><a href="/review_board.bo" id="main_grayfont2" style = "font-size : 14px;">후기 게시판</a></li>
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">공지사항</a></li>
                </ul>
              </div>

            </div>
          </div>
          <div class="col-md-4 ml-auto">

            


            <h2 class="footer-heading mb-4" id="main_grayfont1" >Follow Us</h2>
            <a href="https://www.facebook.com/" class="smoothscroll pl-0 pr-3" target="_blank"><span class="icon-facebook" id="main_grayfont2"></span></a>
            <a href="https://twitter.com/" class="pl-3 pr-3" target="_blank"><span class="icon-twitter" id="main_grayfont2"></span></a>
            <a href="https://www.instagram.com/" class="pl-3 pr-3" target="_blank"><span class="icon-instagram" id="main_grayfont2" ></span></a>
            <a href="https://www.linkedin.com/" class="pl-3 pr-3" target="_blank"><span class="icon-linkedin" id="main_grayfont2" ></span></a>
           
          </div>
        </div>
        <div class="row pt-5 mt-5 text-center">
          <div class="col-md-12">
            <div class="border-top pt-5">
              <p id="main_grayfont2">
                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                Copyright &copy;<script>document.write(new Date().getFullYear());</script> All rights reserved | This template is made with <i class="icon-heart" aria-hidden="true" id="main_grayfont2"></i> <a href="https://colorlib.com" target="_blank" id="main_grayfont2">by Colorlib</a>
                <!-- Link back to Colorlib can't be removed. Template is licensed under CC BY 3.0. -->
                </p>
            </div>
          </div>

        </div>
      </div>
    </footer>
	<!-- 하단 바 종료 -->
    

    <script src="<c:url value="/resources/js/jquery-3.3.1.min.js"/>"></script>
    <script src="<c:url value="/resources/js/popper.min.js"/>"></script>
    <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>
    <script src="<c:url value="/resources/js/owl.carousel.min.js"/>"></script>
    <script src="<c:url value="/resources/js/jquery.sticky.js"/>"></script>
    <script src="<c:url value="/resources/js/jquery.waypoints.min.js"/>"></script>
    <script src="<c:url value="/resources/js/jquery.animateNumber.min.js"/>"></script>
    <script src="<c:url value="/resources/js/jquery.fancybox.min.js"/>"></script>
    <script src="<c:url value="/resources/js/jquery.easing.1.3.js"/>"></script>
    <script src="<c:url value="./resources/js/aos.js"/>"></script>

    <script src="<c:url value="/resources/js/main.js"/>"></script>

		<script>
			/*스크롤 위로올라가기 버튼 시작 script*/
			  $(function() {
			   $(window).scroll(function() {
			     if ($(this).scrollTop() > 500) {
			         $('#MOVE_TOP_BTN').fadeIn();
			     } else {
			         $('#MOVE_TOP_BTN').fadeOut();
			     }
			   });
			   
			   $("#MOVE_TOP_BTN").click(function() {
			     $('html, body').animate({
			         scrollTop : 0
			     }, 400);
			     return false;
			   });
			  });
			
			  /*
			scroll(function(): scroll 함수를 이용
			첫 if문  : 스크롤 위치에 따라 화면에서 맨위로 올라가는 버튼을 나타내고, 사라지도록 설정
			click(function() : 버튼 클릭 이벤트
			animate({ });: animation 을 걸어서 화면 맨위로 이동하도록 설정
			 
			스크롤 위로올라가기 버튼 종료 script*/
		</script>
		
		<script>
			$(function() {
				$(".btn-secondary").on("click mousedown", function() {
					$(this).css("background-color", "rgb(83, 220, 153)");
					$(this).css("border-color", "rgb(83, 220, 153)");
					$(this).css("box-shadow", "0 0 0 0 rgb(83, 220, 153)");
				});
			});
			
		</script>
		
</body>

</html>
