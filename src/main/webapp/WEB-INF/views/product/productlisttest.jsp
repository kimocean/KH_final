<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<%@ include file="../../../common/common.jsp" %>
</head>
<body>
<style>
.scontainer {
	float: left;
	margin-top: -40px;
	margin-left: 100px;
	margin-bottom: 50px;
}
#productListContainer {
	width: 70%;
	margin: 0 auto;
	float: right;
	margin-right: 120px;
	margin-bottom: 50px;
}
#ffooter {
	clear: both;
}
a {
	text-decoration: none;
	color: black;
}
table {
	text-align: center;
}
</style>
<%@ include file="../../../layout/header.jsp" %>
<%@ include file="../../../layout/nav.jsp" %>
<div id="spController">
<%@ include file="../../../layout/sidebar.jsp" %>
<div id="productListContainer">
<h1>게시판 목록</h1>

	<div style="float: right;">
		<select id="cntPerPage" name="sel" onchange="selChange()">
			<option value="5"
				<c:if test="${paging.cntPerPage == 5}">selected</c:if>>5줄 보기</option>
			<option value="10"
				<c:if test="${paging.cntPerPage == 10}">selected</c:if>>10줄 보기</option>
			<option value="15"
				<c:if test="${paging.cntPerPage == 15}">selected</c:if>>15줄 보기</option>
			<option value="20"
				<c:if test="${paging.cntPerPage == 20}">selected</c:if>>20줄 보기</option>
		</select>
	</div> <!-- 옵션선택 끝 -->

<table id="t_productList" class="table table-hover">
	<th><input class="form-check-input" type="checkbox" name="cb_product_all"></th>
	<th>상품명</th>
	<th>카테고리-종류</th>
	<th>카테고리-지역</th>
	<th>상품가격</th>
	<th>배송비</th>
	<c:set var="doneLoop" value="false"/>
	<c:forEach items="${viewAll}" var="list" varStatus="status">
		<c:choose>
			<c:when test="${m_id eq null and not doneLoop}">
				<h1>판매자 권한 필요</h1>
				<c:set var="doneLoop" value="true"/>
			</c:when>
			<c:when test="${m_id eq list.m_id}">
				<tr onClick="location.href='/mall/product/productdetail?product_no=${list.product_no}'">
					<td><input class="form-check-input" type="checkbox" name="cb_product" value="${list.product_no}" ></td>
					<td><c:out value="${list.product_name}" /></td>
					<td><c:out value="${list.category_type_name}" /></td>
					<td><c:out value="${list.category_local_name}" /></td>
					<td><c:out value="${list.product_price}" /></td>
					<td><c:out value="${list.product_dlvyfee}" /></td>
				</tr>
			</c:when>
		</c:choose>
	</c:forEach>
</table>
	<div id="b_productList">
		<button type="button" class="btn btn-warning" onclick="location.href='./productinsert'">등록</button>
		<button type="button" class="btn btn-dark" onclick="remove()">삭제</button>
	</div>
	<!-- start of page -->
	<div style="text-align: center;">		
		<c:if test="${paging.startPage!=1}">
			<a href="/mall/product/productlisttest?nowPage=${paging.startPage-1}&cntPerPage=${paging.cntPerPage}">&lt;</a>
		</c:if>
		<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="p">
			<c:choose>
				<c:when test="${p==paging.nowPage}">
					<b>${p}</b>
				</c:when>
				<c:when test="${p!=paging.nowPage}">
					<a href="/mall/product/productlisttest?nowPage=${p}&cntPerPage=${paging.cntPerPage}">${p}</a>
				</c:when>
			</c:choose>
		</c:forEach>
		<c:if test="${paging.endPage != paging.lastPage}">
			<a href="/mall/product/productlisttest?nowPage=${paging.endPage+1}&cntPerPage=${paging.cntPerPage}">&gt;</a>
		</c:if>
	</div>
	<!-- end of page -->
	<!-- start of search -->
	<div class="form-group row justify-content-center">
			<div class="w100" style="padding-right:10px">
				<select class="form-control form-control-sm" name="searchType" id="searchType">
					<option value="title">제목</option>
					<option value="Content">본문</option>
					<option value="reg_id">작성자</option>
				</select>
			</div>
			<div class="w300" style="padding-right:10px">
				<input type="text" class="form-control form-control-sm" name="keyword" id="keyword">
			</div>
			<div>
				<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</button>
			</div>
		</div>
	<!-- start of search -->
</div>
</div>
<c:url var="getBoardListURL" value="/mall/product/productlisttest"></c:url>
<%@ include file="../../../layout/footer.jsp" %>
<script type="text/javascript">
// 체크박스 선택       
$(document).ready(function(){
	let doneLoop = '${doneLoop}';
	console.log(typeof(doneLoop));
	if(doneLoop === "true") {
		console.log("if문 거침");
//		$("#t_productList").html("");
		$("#t_productList").remove();
		$("#b_productList").html("");
	}
	
	let cb_product = document.getElementsByName("cb_product");
	let cb_product_cnt = cb_product.length;
		
	$("input[name='cb_product_all']").click(function(){
		var chk_listArr = $("input[name='cb_product']");
		for (var i=0; i<chk_listArr.length; i++){
			chk_listArr[i].checked = this.checked;
		}
	});
	$("input[name='cb_product']").click(function(){
		if($("input[name='cb_product']:checked").length == cb_product_cnt){
			$("input[name='cb_product_all']")[0].checked = true;
		}
		else{
			$("input[name='cb_product_all']")[0].checked = false;
		}
	});
})
;
function remove() {
	let obj = document.querySelectorAll("input[name='cb_product']"); //체크 박스 -> class가 check
	let noList = new Array();
	for (let i = 0; i< obj.length; i++) {
		if (obj[i].checked == true) {
			noList.push(obj[i].value);
			console.log(noList);
		}
	}
	$.ajax({
		type: 'POST',
        url: 'productcheckdelete',
		traditional: true,
		dataType: 'text',
		// contentType: 'application/json; charset=utf-8',
		data: {
            'product_nos': noList
		},
	}).done(function(res) {
		location.reload();
		})
	.fail(function (error) {
		console.log(JSON.stringify(error));
	})
}

function selChange() {
	let sel = document.getElementById('cntPerPage').value;
	location.href="productlisttest?nowPage=${paging.nowPage}&cntPerPage="+sel;
}

$(document).on('click', '#btnSearch', function(e){
	e.preventDefault();
	let url = "${pageContext.request.contextPath}/mall/product/productlisttest";
	url = url + "?searchType=" + $('#searchType').val();
	url = url + "&keyword=" + $('#keyword').val();
	location.href = url;
	console.log(url);

});
</script>
</body>
</html>