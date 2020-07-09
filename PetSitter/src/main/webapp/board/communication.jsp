<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.spring.petsitter.board.*" %>
<%
	ArrayList<CommunicationBoardVO> boardList = (ArrayList<CommunicationBoardVO>)request.getAttribute("board_list");
	int listcount = ((Integer)request.getAttribute("listcount")).intValue();
	int nowpage = ((Integer)request.getAttribute("page")).intValue();
	int maxpage = ((Integer)request.getAttribute("maxpage")).intValue();
	int startpage = ((Integer)request.getAttribute("startpage")).intValue();
	int endpage = ((Integer)request.getAttribute("endpage")).intValue();
	String PETSITTER_ID = (String)request.getAttribute("petsitter_id");
	
	// 세션 종료시 홈으로
	if(session.getAttribute("id") == null) {
		out.println("<script>");
		out.println("location.href = 'home.me'");
		out.println("</script>");
	}
%>
<!-- 고객과의 소통 -->

<!doctype html>
<html lang="en">


<style>
	/*펫시터 메인 폰트컬러 */
	.main_mintfont{
	color : #53DC98!important;
	}
	.main_whitefont{
	color : #ffffff!important;
	}
	#main_whitefont2{
	color : #ffffff!important;
	}
	#main_grayfont1{
	color : #707070!important;
	}
	#main_grayfont2{
	color : #949494!important;
	}
	/*펫시터 메인 폰트컬러 끝*/
	

	/* 제이쿼리 로인해 색 폰트 사이즈 수정을 위해 jsp파일안에 스타일 오버라이트 
resource/css/style.css 부분에서 찾은 부분(최종은 jsp에있는 style로 적용 됨) */
	.site-mobile-menu {
	width: 300px;
	position: fixed;
	right: 0;
	z-index: 2000;
	padding-top: 20px;
	background: #d3d3d3!important;
	height: calc(100vh);
  -webkit-transform: translateX(110%);
	-ms-transform: translateX(110%);
	transform: translateX(110%);
	-webkit-box-shadow: -10px 0 20px -10px rgba(0, 0, 0, 0.1);
	box-shadow: -10px 0 20px -10px rgba(0, 0, 0, 0.1);
	-webkit-transition: .3s all ease-in-out;
	-o-transition: .3s all ease-in-out;
	transition: .3s all ease-in-out; }
	  
	.site-mobile-menu .site-mobile-menu-body {
	background: #d3d3d3!important;
	overflow-y: scroll;
	-webkit-overflow-scrolling: touch;
	position: relative;
	padding: 0 20px 20px 20px;
	height: calc(100vh - 52px);
	padding-bottom: 150px; }
	  /* 기본 상단바 끝*/
	  
	/*최하단바 시작*/
	.site-footer {
	padding: 4em 0;
	background: #e9e9e9!important; 
	}
	/*최하단바 종료*/
	/*테이블 css 시작*/
	th, td {
			color : #5e5e5e!important;
			font-size : 15px;
		}
		
		/*nth-child(1) 칼럼 순서 불러서 css 입혀준다.*/
		th:nth-child(1), th:nth-child(2), th:nth-child(3), th:nth-child(4), th:nth-child(5) {
			text-align: center;
  	}
	
   td:nth-child(1), td:nth-child(2), td:nth-child(4), td:nth-child(5) {
			text-align: center;
  	}
  	.table-striped > tbody > tr:nth-child(2n+1) > td, .table-striped > tbody > tr:nth-child(2n+1) > th {
   	background-color: #F8F8F8;
		}
		/*테이블 css 종료*/	  
	  
	  
</style>


  <head>
    <title>펫시터와의 소통 게시판</title>
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
    
    <!-- 언택CSS -->
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/UT_CSS/communication.css">
    
  </head>
  <body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">
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
              <a href="#" class=""><span class="mr-2  icon-envelope-open-o"></span> <span class="d-none d-md-inline-block">petsitter@yourdomain.com</span></a>
              <span class="mx-md-2 d-inline-block"></span>
              <a href="#" class=""><span class="mr-2  icon-phone"></span> <span class="d-none d-md-inline-block">1+ (234) 5678 9101</span></a>
              <div class="float-right">
                <%
              		if(session.getAttribute("id") == null) {
              	%>
                <a href="loginform.me" ><span class = "font-size-14" >로그인 및 회원가입</span></a>
                <span class="mx-md-2 d-inline-block"></span>
                <%} else if(((String)session.getAttribute("id")).contains("@")){ %> <!-- 일반 회원 마이 페이지 -->
                <a href="memberinfo.me?id=${id}"><span class="font-size-14" >${name }님</span></a>&nbsp;&nbsp;&nbsp;
                <a href="logout.me"><span class="font-size-14">로그아웃</span></a>
                <%} else {%> <!-- 펫시터 마이 페이지 -->
                <a href="petsitterinfo.me?id=${id}"><span class="font-size-14" >${name }님</span></a>&nbsp;&nbsp;&nbsp;
                <a href="logout.me"><span class="font-size-14">로그아웃</span></a>
                <%} %>
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <header class="site-navbar js-sticky-header site-navbar-target" role="banner" style = "background : rgba(83,220,152,0.86);">
        <div class="container">
          <div class="row align-items-center position-relative">
            <div class="site-logo">
              <a href="./home.me"><span class="main_whitefont">보살펴조</span></a>
            </div>
            <div class="col-12">
              <nav class="site-navigation text-right ml-auto " role="navigation">
                <ul class="site-menu main-menu js-clone-nav ml-auto d-none d-lg-block">
                  <li><a href="reservation2.br" class="nav-link" id="main_whitefont2" style = "font-size:15px">방문 돌봄</a></li>
	                <li><a href="reservation1.br" class="nav-link" id="main_whitefont2" style = "font-size:15px">위탁 돌봄</a></li>
                  <li><a href="home.me" class="nav-link" id="main_whitefont2" style = "font-size:15px">반려동물 전문가 상담</a></li>
                  <li><a href="home.me" class="nav-link" id="main_whitefont2" style = "font-size:15px">후기 게시판</a></li>
                  <li><a href="home.me" class="nav-link" id="main_whitefont2" style = "font-size:15px">공지사항</a></li>
                </ul>
              </nav>
            </div>
            <div class="toggle-button d-inline-block d-lg-none"><a href="#" class="site-menu-toggle py-5 js-menu-toggle text-black"><span class="icon-menu h3"></span></a>
            </div>
          </div>
        </div>

      </header>
<!-- 본 기능 추가 시작 -->
<section class="top_box">
	<div class="container">
		<div class="row">
			<div class="col-6">
				<div class="top_box_title1">
					<h1 class="top_box_text1">고객과의 소통</h1>
					<p class="top_box_text2">상호간 소통을 통해 가까워지는 시간을 가지세요!</p>
				</div>
			</div>
			<div class="col-6">
				<div class="top_box_title2">	
					<img class="top_box_img" src="resources/images/pet/Bs_Dog1.PNG">
				</div>
			</div>
		</div>
	</div>
</section>

<section class="middle_box">
	<div class="container">
		<div class="row">
			<div class="col">
				<div class="middle_box_right">
					<a href="communicationWrite_member.bo?petsitterid=<%=PETSITTER_ID %>" id="question" class="right_btn">질문남기기</a>
				</div>
			
				<div class="middle_table">
					<table class="table table-sm table-hover table-striped" style="text-align: center;">
						<thead>
							<tr>
								<th width="50px">번호</th>
								<th width="100px">답변여부</th>
								<th width="20px">구분</th>
								<th width="180px">제목</th>
								<th width="100px">작성자</th>
								<th width="100px">등록일자</th>
							</tr>
						</thead>
						
						<%
							int num = listcount - ((nowpage - 1) * 10);
							if(boardList != null) {
								for(int i = 0; i < boardList.size(); i++) {
									CommunicationBoardVO board = (CommunicationBoardVO)boardList.get(i);
						%>
						
						<tbody id="getContent">
							<tr id="clickText_<%=num %>" style="cursor:pointer;">
								<td width="50px">
									<input type="hidden" id="textValue" value="<%=board.getBOARD_NUM() %>">
									<%=num %>
								</td>
								<td width="100px"><%=board.getBOARD_CONDITION() %></td>
								<td width="50px"><%=board.getBOARD_TYPE() %></td>
								<td width="180px"><%=board.getBOARD_SUBJECT() %></td>
								<td width="100px"><%=board.getBOARD_WRITER() %></td>
								<td width="100px"><%=board.getBOARD_REALDATE() %></td>
							</tr>
							<tr class="viewText" id="viewText_<%=num %>" style="display: none;">
								<td colspan="3"></td>
								<td width="180px"><%=board.getBOARD_CONTENT() %></td>
								<td colspan="2"></td>
							</tr>
						</tbody>
						
						<%
							num--;
								}
							} 
						%>
						
						</table>
					</div>
					<table class="col-md-12 text-center">
						<tr align=center height = 20>
							<td colspan=7 style="font-family:Tahoma;font-size:10pt;">
								<%if(nowpage <= 1) { %>
								<&nbsp;
								<%}else { %>
								<a href="./communication_member.bo?petsitterid=<%=PETSITTER_ID %>&page=<%=nowpage - 1 %>"> < </a>
								<%} %>
								
								<%for(int a = startpage; a <= endpage; a++) {
									if(a == nowpage) {%>
									<%=a %>
									<%}else { %>
									<a href = "./communication_member.bo?petsitterid=<%=PETSITTER_ID %>&page=<%=a %>"><%=a %></a>
									&nbsp;
									<%} %>
								<%} %>
								
								<%if(nowpage >= maxpage) { %>
								>
								<%}else { %>
								<a href = "./communication_member.bo?petsitterid=<%=PETSITTER_ID %>&page=<%=nowpage + 1 %>"> > </a>
								<%} %> 
							</td>
						</tr>
					</table>
					<br/><br/><!-- br은 제거가능 -->

			</div>
		</div>
	</div>
</section>

<section class="bottom_box">
	<div class="container">
		
		<div class="row justify-content-center">
			<div class="col">
				<div class="bottom_body1">
					<div class="bottom_img1">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs1" alt="...">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs2" alt="...">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs3" alt="...">
					</div>
				</div>
			</div>
		</div>
				
		<div class="row justify-content-center">
			<div class="col">
				<div class="bottom_body2">
					<div class="bottom_img2">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs4" alt="...">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs5" alt="...">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs6" alt="...">
					</div>
				</div>
			</div>
		</div>
		
		<div class="row justify-content-center">
			<div class="col">
				<div class="bottom_body3">
					<div class="bottom_img3">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs7" alt="...">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs8" alt="...">
						<img src="resources/images/dog03.jpg" class="bottom_imgs" id="bottom_imgs9" alt="...">
					</div>
				</div>
			</div>
		</div>
		
		<div class="row justify-content-center">
			<div class="col">
			<form>
				<div class="bottom_button">
					<button type="button" class="photo_more">사진 더보기</button>
				</div>
			</form>
			</div>
		</div>
		
	</div>
</section>      
      


      
      
      
      
      
      
<!-- 본 기능 추가 종료 -->
      
      

      
      <footer class="site-footer">
      <div class="container">
        <div class="row">
          <div class="col-md-6">
            <div class="row">
              <div class="col-md-7">
                <h2 class="footer-heading mb-4" id="main_grayfont1">About Us</h2>
                <p id="main_grayfont2" style = "font-size : 14px;">반려동물들을 위해 고객과 펫시터와를 연결시켜주는 매칭 플렛폼입니다.. 신뢰와 안전을 위해 최선을 다하겠습니다.</p>
              </div>
              <div class="col-md-4 ml-auto">
                <h2 class="footer-heading mb-4" id="main_grayfont1">CONTANTS</h2>
                <ul class="list-unstyled">
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">방문 돌봄</a></li>
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">위탁 돌봄</a></li>
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">반려동물 전문가 상담</a></li>
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">후기 게시판</a></li>
                  <li><a href="#" id="main_grayfont2" style = "font-size : 14px;">공지사항</a></li>
                </ul>
              </div>

            </div>
          </div>
          <div class="col-md-4 ml-auto">

            

						<form>
            <h2 class="footer-heading mb-4" id="main_grayfont1">Follow Us</h2>
            <a href="https://www.facebook.com/" class="smoothscroll pl-0 pr-3" target="_blank"><span class="icon-facebook" id="main_grayfont2" ></span></a>
            <a href="https://twitter.com/" class="pl-3 pr-3" target="_blank"><span class="icon-twitter" id="main_grayfont2" ></span></a>
            <a href="https://www.instagram.com/" class="pl-3 pr-3" target="_blank"><span class="icon-instagram" id="main_grayfont2" ></span></a>
            <a href="https://www.linkedin.com/" class="pl-3 pr-3" target="_blank"><span class="icon-linkedin" id="main_grayfont2" ></span></a>
            </form>
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
      
      
 <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" ></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" ></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js" ></script>
		
		<script src="<c:url value="/resources/js/owl.carousel.min.js"/>"></script>
    <script src="<c:url value="/resources/js/jquery.sticky.js"/>"></script>

    <script src="<c:url value="./resources/js/aos.js"/>"></script><!-- nav 상단바 반응형웹 적용1 -->

    <script src="<c:url value="/resources/js/main.js"/>"></script><!-- nav 상단바 반응형웹 적용2 -->
 		
 		<!-- 아이콘 -->   
		<script src="https://use.fontawesome.com/releases/v5.2.0/js/all.js"></script>
		
		<script>
			/* 글 눌렀을 때 내용 보이기 함수 */
			$(function() {
				$(".viewText").hide();
				let num = '<%=listcount-((nowpage - 1)*10)%>';
				console.log(num);
				for(let i = 1; i <= num; i++) {
					$("#clickText_" + i).click(function() {
						if($("#viewText_" + i).css("display") == "none") {
							$("#viewText_" + i).show();
						} else {
							$("#viewText_" + i).hide();
						}
					});
				}
				
			});
		</script>
		
</body>
</html>