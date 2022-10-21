<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>옵션 리스트</title>
<%@ include file="../../../common/common.jsp"%>
<script>
         // 체크박스 선택       
	$(function(){
			var chkObj = document.getElementsByName("RowCheck");
			var rowCnt = chkObj.length;
			
			$("input[name='allCheck']").click(function(){
				var chk_listArr = $("input[name='RowCheck']");
				for (var i=0; i<chk_listArr.length; i++){
					chk_listArr[i].checked = this.checked;
				}
			});
			$("input[name='RowCheck']").click(function(){
				if($("input[name='RowCheck']:checked").length == rowCnt){
					$("input[name='allCheck']")[0].checked = true;
				}
				else{
					$("input[name='allCheck']")[0].checked = false;
				}
			});
		});
		function deleteValue(){
			var url = "optiondelete";    // Controller로 보내고자 하는 URL
			var valueArr = new Array();
		    var list = $("input[name='RowCheck']");
		    for(var i = 0; i < list.length; i++){
		        if(list[i].checked){ //선택되어 있으면 배열에 값을 저장함
		            valueArr.push(list[i].value);
		        }
		    }
		    if (valueArr.length == 0){
		    	alert("선택된 글이 없습니다.");
		    }
		    else{
				var chk = confirm("정말 삭제하시겠습니까?");				 
				$.ajax({
				    url : url,                    // 전송 URL
				    type : 'POST',                // POST 방식
				    traditional : true,
				    data : {
				    	valueArr : valueArr        // 보내고자 하는 data 변수 설정
				    },
	                success: function(jdata){
	                    if(jdata = 1) {
	                        alert("삭제 성공");
	                        location.replace("optionpopup") //list 로 페이지 새로고침
	                    }
	                    else{
	                        alert("삭제 실패");
	                    }
	                }
				});
			}
		}
</script>
</head>

<body>
	<table id="t_optionList" border="1">
		<th><input type="checkbox" name="allCheck" value="${list.option_no}"></th>
		<th>옵션명</th>
		<th>옵션값</th>
		<th>옵션가</th>
		<th>재고수량</th>
		<c:forEach items="${optionSelectAll}" var="list">
			<tr>
				<td><input type="checkbox" name="RowCheck"></td>
				<td><c:out value="${list.option_name}" /></td>
				<td><c:out value="${list.option_value}" /></td>
				<td><c:out value="${list.option_price}" /></td>
				<td><c:out value="${list.option_stock}" /></td>
			</tr>
		</c:forEach>
	</table>
	<a href="/product/optioninsert">등록</a>
	<input type="button" value="삭제" onclick="deleteValue()">
</body>

</html>