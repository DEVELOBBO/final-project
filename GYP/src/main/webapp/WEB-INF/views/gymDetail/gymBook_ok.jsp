\<%@page import="com.exe.dto.CustomInfo"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("UTF-8");
	String cp = request.getContextPath();

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Favicon -->
	<link rel="icon" href="/gyp/resources/img/core-img/favicon.ico">
	<!-- Core Stylesheet -->
	<link rel="stylesheet" href="/gyp/resources/css/style.css">
	<!-- 플로팅 -->
	<link rel="stylesheet" href="/gyp/resources/css/floating.css">
	<!-- font -->
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400&display=swap" rel="stylesheet">
	
<title>GYP</title>
</head>
<body style="font-family: 'Noto Sans KR', sans-serif;">
	
	<jsp:include page="/WEB-INF/views/layout/header_over.jsp" />
	<jsp:include page="/WEB-INF/views/layout/header_below.jsp" />

    <!-- ##### Contact Area Start ##### -->
    <section class="contact-area section-padding-100">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="contact-title">
                        <h3>예약 완료</h3>
                    </div>
                </div>
            </div>

            <div class="row">
                <div class="col-12">
                    <div class="contact-content">
                        <!-- Contact Form Area -->
                        <div class="contact-form-area">
                        	<div class="row">
	                        	<div class="col-2">
	                        		<img alt="reservation-check" src="/gyp/resources/img/check.png" width="180px" >
	                        	</div>
	                          	<div class="mb-70 col-10">
									<h4>고객님의 예약이 완료되었습니다.</h4>
									<h6>주문내역은 마이페이지에서 확인할 수 있습니다.</h6>
									주문 내역 및 배송에 관한 문의는 <a href="#">Q&A</a> 게시판으로 <br/>
									문의해주시기 바랍니다. 
								</div>
                        	</div> 
								
							<!-- 임시 링크..! 링크 수정 필요 -->
						     <div class="fitness-buttons-area mb-100">
						   		<!-- 운동용품 쇼핑하기 -->	
						         <a href="/gyp/productList.action" class="btn fitness-btn btn-2 m-2">운동용품 쇼핑하기</a>
						         <!-- 더 둘러보기 -->
						         <a href="/gyp/gymList.action" class="btn fitness-btn btn-2 m-2">더 둘러보기</a>
						         <!-- 예약 확인하기 -->
						         <a href="/gyp/myPage.action" class="btn fitness-btn btn-2 m-2">예약 확인하기</a>
						     </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- ##### Contact Area End ##### -->


	

	
	
	<jsp:include page="/WEB-INF/views/layout/footer.jsp" />

	
    <!-- ##### All Javascript Script ##### -->
    <!-- jQuery-2.2.4 js -->
    <script src="/gyp/resources/js/jquery/jquery-2.2.4.min.js"></script>
    <!-- Popper js -->
    <script src="/gyp/resources/js/bootstrap/popper.min.js"></script>
    <!-- Bootstrap js -->
    <script src="/gyp/resources/js/bootstrap/bootstrap.min.js"></script>
    <!-- All Plugins js -->
    <script src="/gyp/resources/js/plugins/plugins.js"></script>
    <!-- Active js -->
    <script src="/gyp/resources/js/active.js"></script>
    


</body>
</html>