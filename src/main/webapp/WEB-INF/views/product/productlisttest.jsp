<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>list</title>
<%@ include file="../../../common/common.jsp" %>
<script>
$(document).ready(function() {
	// dlvy_fee 음수 양수로 보이도록
	for(i=0;i<$('[name="dlvy_fee"]').length;i++) {
		let dlvy_fee = $('[name="dlvy_fee"]');
		let dlvy_fee2 = dlvy_fee.eq(i).val();
		if(dlvy_fee2 < 0) {
			$('[name="dlvy_fee"]').eq(i).val($('[name="dlvy_fee"]').eq(i).val() * -1)
		}
	}
})
</script>
</head>
<body>
게시판 목록
  <table id="t_productList" border="1">
    <th>상품명</th>
    <th>상품값</th>
    <th>상품상세</th>
    <th>배송비</th>
    <c:forEach items="${productSelectAll}" var="list">
  <tr>
      <td><a href="/mall/product/productdetail?product_no=${list.product_no}"><c:out value="${list.product_name}" /></a></td>
      <td><c:out value="${list.product_price}" /></td>
      <td><c:out value="${list.product_detail}" /></td>
      <td><input type="text" value="<c:out value="${list.product_dlvyfee}" />" name="dlvy_fee" readonly></td>
    </tr>
    </c:forEach>
  </table>
    </table>
<a href="./productinsert">등록</a>
</body>
</html>