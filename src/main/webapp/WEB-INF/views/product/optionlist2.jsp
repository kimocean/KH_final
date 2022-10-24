<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옵션 리스트</title>
<%@ include file="../../../common/common.jsp" %>
<script>
        // 체크박스 전체 체크/해제
         function cb_selectAll(cb_selectAll) {
           const cb_option = document.getElementsByName('cb_option');
           document.getElementsByName
           cb_option.forEach((checkbox) => {
             checkbox.checked = cb_selectAll.checked;
           })
         } // end of function cb_selectAll

      </script>
</head>

<body>
	<table id="t_optionList" border="1">
		<th><input type="checkbox" name="cb_option" value="<c:out value="${list.option_no}" />"></th>
		<th>옵션명</th>
		<th>옵션값</th>
		<th>옵션가</th>
		<th>재고수량</th>
		<c:forEach items="${optionSelectAll}" var="list">
			<tr>
				<td><input type="checkbox" name="cb_option"></td>
				<td><c:out value="${list.option_name}" /></td>
				<td><c:out value="${list.option_value}" /></td>
				<td><c:out value="${list.option_price}" /></td>
				<td><c:out value="${list.option_stock}" /></td>
			</tr>
		</c:forEach>
	</table>
	<a href="/mall/product/optioninsert">등록</a>
	<input type="button" value="삭제" onclick="b_checkDelete()">
</body>

</html>