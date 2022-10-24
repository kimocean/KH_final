<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옵션 추가</title>
<%@ include file="../../../common/common.jsp" %>
</head>
<body>
	<form action="/mall/product/optiondetail?option_no=${optionSelectOne.option_no}" method="post">
		<table border="1">
			<th>옵션명</th>
			<th>옵션값</th>
			<th>옵션가</th>
			<th>재고수량</th>
			<tr>
				<td><input type="text" name="option_name" value="${optionSelectOne.option_name}"></td>
				<td><input type="text" name="option_value" value="${optionSelectOne.option_value}"></td>
				<td><input type="text" name="option_price" value="${optionSelectOne.option_price}"></td>
				<td><input type="text" name="option_stock" value="${optionSelectOne.option_stock}"></td>
			</tr>
		</table>
		옵션번호 <input type="text" name="option_no" value="${optionSelectOne.option_no}">
		<br/>
		<button type="submit">수정</button>
      <!--   <button type="button">추가</button> -->
	</form>
	<c:import url="/product/optionlist" />
</body>
</html>