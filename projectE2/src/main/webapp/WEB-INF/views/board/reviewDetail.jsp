<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 작성</title>
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style type="text/css">
* {
	margin: 0;
	padding: 0;
}

div {
	display: block;
}

body {
	position: relative;
	margin: 0 auto;
	font-size: 100%;
	line-height: 100%;
	text-size-adjust: 100%;
	-webkit-text-size-adjust: 100%;
	word-break: keep-all;
}

.ReviewWritenpage_Container {
	width: 687px;
	margin: 50px auto 62px;
}

.DeptName {
	display: block;
	width: 687px;
	font-size: 28px;
	line-height: 1.462;
	color: #ff7100;
	word-break: break-word;
}

.ReviewWritenpage_DeptName {
	margin-bottom: 10px;
	border: 0 none;
	text-align: center;
}

.ReviewPoint {
	text-align: center;
	margin-bottom: 10px;
}

.ReviewWritenPage_FormWrap {
	width: 687px;
	position: relative;
	margin-bottom: 10px;
}

.ReviewWritenPage_Content {
	border: 1px solid #DBDBDB;
	border-radius: 3px;
	box-sizing: border-box;
	padding: 16px;
	height: 300px;
}

.ReviewWritenPage_Title {
	margin-bottom: 10px;
	height: 30px;
	border-bottom: 1px solid lightgray;
}

.ReviewWritenPage_Title input {
	width: 100%;
	border: 0;
}

.ReviewWritenPage_Editor {
	overflow: hidden;
	overflow-wrap: break-word;
	height: 200px;
	display: block;
	width: 100%;
	border: 0;
	resize: none;
	cursor: text;
}

.ReviewWritenPage_Editor:placeholder-shown {
	color: #CBCBCB;
}

.ReviewWritenPage_TextWrap {
	width: 687px;
	margin-bottom: 22px;
	position: relative;
}

.notice {
	font-size: 12px;
	color: red;
	margin-bottom: 5px;
}

.ReviewWritenPage_TextLength {
	position: absolute;
	right: 0;
	font-size: 12px;
	color: #7F7F7F;
	margin-right: 10px;
}

.ReviewWritenPage_PictureWrap {
	position: relative;
	width: 687px;
	margin-bottom: 41px;
	border: 0;
}

.ReviewWritenPage_ButtonsWrap {
	width: 687px;
	border: 0 none;
	display: flex;
	justify-content: flex-end;
}

.ReviewWritingPage_CalcelButton {
	min-width: 140px;
	min-height: 50px;
	margin-right: 16px;
	padding-left: 14px;
	padding-right: 14px;
	border: 1px solid #7F7F7F;
	border-radius: 50px;
	font-size: 16px;
	color: #7F7F7F;
	text-align: center;
	background-color: #FFFFFF;
	cursor: pointer;
}

.ReviewWritingPage_SubmitButton {
	min-width: 140px;
	min-height: 50px;
	padding-left: 14px;
	padding-right: 14px;
	border: 1px solid #ff7100;
	border-radius: 50px;
	font-size: 16px;
	color: #FFFFFF;
	text-align: center;
	background-color: #ff7100;
}

.ReviewWritingPage_SubmitButton_Deactive {
	border-color: #E9E9E9;
	background-color: #E9E9E9;
	color: #FFFFFF;
	cursor: not-allowed;
	pointer-events: none;
}

ul, li {
	list-style: none;
}

.PictureContainer {
	position: relative;
	border: 0;
}

.PictureContainer_PictureList {
	margin-top: 5px;
	width: 100%;
}

.PictureContainer_PictureList img {
	width: 98px;
	height: 98px;
	margin-right: 9px;
	margin-bottom: 9px;
}

.PictureContainer_PictureItem {
	position: absolute;
	margin-right: 9px;
	margin-bottom: 9px;
}

#star_grade a {
	display: inline-block;
	font-size: 32px;
	text-decoration: none;
	color: gray;
	width: 32px;
}

#star_grade a.on {
	color: red;
}

.image-Content {
	width: 687px;
	position: relative;
	margin-bottom: 10px;
	white-space: nowrap;
	overflow-x: auto;
	overflow-y: hidden;
	overflow-scrolling: touch;
	-webkit-overflow-scrolling: touch;
}

.image_wrap {
	font-size: 0;
	line-height: 0;
}

.reviewPicture>img {
	display: inline-block;
	width: 200px;
	height: 200px;
	margin-right: 6px;
	background-size: cover;
	background-position: 50% 50%;
	background-repeat: no-repeat;
	cursor: pointer;
}

.reviewPicture {
	display: inline-block;
}
</style>

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript">
	// 별점 스크립트		
	function mark(star) {
		document.myForm.star.value = star;
	}

	$('#star_grade a').click(function() {
		$(this).parent().children("a").removeClass("on"); /* 별점의 on 클래스 전부 제거 */
		$(this).addClass("on").prevAll("a").addClass("on"); /* 클릭한 별과, 그 앞 까지 별점에 on 클래스 추가 */
		return false;
	});

	// 리뷰 글자수 계산 스크립트
	// 제목/리뷰내용을 작성해야 버튼 활성화
	// 글자수 유효성 검사
	$(document)
			.ready(
					function() {

						$('#review')
								.keyup(
										function() {
											var review = $(this).val();
											var title = $('#title').val();
											$('#lengthResult').html(
													review.length + ' / 2000');

											if (review.length > 2000) {
												alert('최대 2000자까지 입력 가능합니다.');
												$(this).val(
														review.substring(0,
																2000));
												$('#lengthResult').html(
														'2000 / 2000');
											}

											if (review.length >= 1
													&& title.length >= 1) {
												$('#submitBtn')
														.removeClass(
																"ReviewWritingPage_SubmitButton_Deactive");
											} else {
												$('#submitBtn')
														.addClass(
																'ReviewWritingPage_SubmitButton_Deactive');
											}
										});

						$('#title')
								.keyup(
										function() {
											var review = $('#review').val();
											var title = $(this).val();

											if (title.length > 100) {
												alert('최대 100자까지 입력 가능합니다.');
												$(this)
														.val(
																title
																		.substring(
																				0,
																				100));
											}

											if (review.length >= 1
													&& title.length >= 1) {
												$('#submitBtn')
														.removeClass(
																"ReviewWritingPage_SubmitButton_Deactive");
											} else {
												$('#submitBtn')
														.addClass(
																'ReviewWritingPage_SubmitButton_Deactive');
											}
										});

					});

	function fn_UpdateReview(form) {

		form.action = 'UpdateReview';
		form.submit();
	}
</script>

</head>
<body>
	<c:if test="${rdto.cNickname ==sessionScope.cNickname }">

		<form name="myForm" method="post" enctype="multipart/form-data">
			<div class="ReviewWritenpage_Container">
				<div class="ReviewWritenpage_DeptName">
					<strong class="DeptName">${deptdto.dName}</strong>
				</div>
				<div class="ReviewPoint">
					<p id="star_grade">
						<c:forEach var="i" begin="0" end="5" step="1">

							<c:if test="${rdto.rPoint > i }">
								<a class="on">★</a>
							</c:if>
							<c:if test="${rdto.rPoint < i }">
								<a>★</a>
							</c:if>

						</c:forEach>
					</p>
					<input id="star" type="hidden" name="rPoint"
						value='${rdto.rPoint }' />
				</div>

				<div class="ReviewWritenPage_ContentWrap">
					<div class="ReviewWritenPage_FormWrap">
						<div class="ReviewWritenPage_Content">
							<div class="ReviewWritenPage_Title">
								<input id="title" type="text" name="rTitle" size="50"
									placeholder="제목을 입력하세요." value='${rdto.rTitle}'>
							</div>
							<textarea name="rContent" class="ReviewWritenPage_Editor"
								id="review" rows="1" cols="1"
								placeholder="주문하신 메뉴는 어떠셨나요? 식당의 분위기와 서비스도 궁금해요!">${rdto.rContent}</textarea>
							<p class="ReviewWritenPage_TextLength" id="lengthResult">0 /
								2000</p>
						</div>
					</div>
					<div class="image-Content">
						<div class="image_wrap">
							<c:set var="img" value="${rdto.rPoto }"></c:set>
							<c:forEach var="img" items="${fn:split(img,',') }">
								<div class="reviewPicture">
									<img alt="${img }"
										src="${pageContext.request.contextPath}/resources/storage/review_img/${img}">
								</div>

							</c:forEach>
						</div>
					</div>

					<div class="ReviewWritenPage_TextWrap">
						<div class="ReviewWritenPage_PictureWrap">
							<input type="file" id="input_file" name="rPoto" multiple /> <a
								class="notice">10MB이하의 파일만 업로드 가능합니다.</a>
						</div>
					</div>
				</div>
				<div class="ReviewWritenPage_ButtonsWrap">
					<input type="hidden" value="${cNo }" name="cNo"> <input
						type="hidden" value="${deptDTO.dSaup_no }" name="dSaup_no">
					<input type="hidden" value="${rdto.rNo }" name="rNo"> <input
						type="button" id="submitBtn"
						class="ReviewWritingPage_SubmitButton ReviewWritingPage_SubmitButton_Deactive"
						onclick="fn_UpdateReview(this.form)" value="수정하기" />
				</div>
			</div>
		</form>
	</c:if>
	<c:if test="${rdto.cNickname != sessionScope.cNickname }">
		<form name="myForm" method="post" enctype="multipart/form-data">
			<div class="ReviewWritenpage_Container">
				<div class="ReviewWritenpage_DeptName">
					<strong class="DeptName">${deptdto.dName}</strong>
				</div>
				<div class="ReviewPoint">
					<p id="star_grade">
						<c:forEach var="i" begin="0" end="5" step="1">

							<c:if test="${rdto.rPoint > i }">
								<a class="on">★</a>
							</c:if>
							<c:if test="${rdto.rPoint < i }">
								<a>★</a>
							</c:if>

						</c:forEach>
					</p>
					<input id="star" type="hidden" name="rPoint" />
				</div>

				<div class="ReviewWritenPage_ContentWrap">
					<div class="ReviewWritenPage_FormWrap">
						<div class="ReviewWritenPage_Content">
							<div class="ReviewWritenPage_Title">
								<!-- <input id="title" type="text" name="rTitle" size="50" placeholder="제목을 입력하세요."/> -->
								${rdto.rTitle}
							</div>
							<pre>${rdto.rContent }</pre>
						</div>
					</div>
					<div class="image-Content">
						<div class="image_wrap">
							<c:set var="img" value="${rdto.rPoto }"></c:set>
							<c:forEach var="img" items="${fn:split(img,',') }">
								<div class="reviewPicture">
									<img alt="${img }"
										src="${pageContext.request.contextPath}/resources/storage/review_img/${img}">
								</div>

							</c:forEach>
						</div>
					</div>
				</div>
				-
			</div>
		</form>
	</c:if>

</body>
</html>