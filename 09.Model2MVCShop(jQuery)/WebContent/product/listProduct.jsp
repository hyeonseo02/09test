<%@ page contentType="text/html; charset=EUC-KR"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>��ǰ �����ȸ</title>

<link rel="stylesheet" href="/css/admin.css" type="text/css">

<script src="http://code.jquery.com/jquery-2.1.4.min.js"></script>
<script type="text/javascript">

	function fncGetList(currentPage) {
		$("#currentPage").val(currentPage)
		$("form").attr("method","POST").attr("action","/product/listProduct?menu=${param.menu}").submit();
	}
	
	$(function(){
		$("td.ct_btn01:contains('�˻�')").on("click",function(){
			fncGetList(1);
		});
		
		$(".ct_list_pop td:nth-child(3)").on("click",function(){
			if($(this).data("trancode")==''){
				if ("${param.menu}"=="manage") {
					self.location ="/product/updateProduct?menu=manage&prodNo="+$(this).data("prodno");
				} else {
					self.location ="/product/getProduct?menu=search&prodNo="+$(this).data("prodno");
				}
			}
		});

		$(".ct_list_pop td:nth-child(9):contains('(����ϱ�)')").on("click",function(){
			self.location = "/purchase/updateTranCode?tranCode=2&prodNo="+$(this).data("prodno");
		})

		$(".ct_list_pop:nth-child(4n+6)" ).css("background-color" , "whitesmoke");
		
		
	});	
</script>
</head>

<body bgcolor="#ffffff" text="#000000">

	<div style="width: 98%; margin-left: 10px;">



		<table width="100%" height="37" border="0" cellpadding="0"
			cellspacing="0">
			<tr>
				<td width="15" height="37"><img src="/images/ct_ttl_img01.gif"
					width="15" height="37" /></td>
				<td background="/images/ct_ttl_img02.gif" width="100%"
					style="padding-left: 10px;">
					<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="93%" class="ct_ttl01"><c:if
									test="${param.menu =='manage' }">��ǰ����</c:if> <c:if
									test="${param.menu =='search' }">��ǰ�����ȸ</c:if></td>
						</tr>
					</table>
				</td>
				<td width="12" height="37"><img src="/images/ct_ttl_img03.gif"
					width="12" height="37" /></td>
			</tr>
		</table>


		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			style="margin-top: 10px;">
			<tr>

				<td align="right"><select name="searchCondition"
					class="ct_input_g" style="width: 80px">
						<option value="0"
							${! empty search.searchCondition && search.searchCondition==0 ? "selected" : "" }>��ǰ��ȣ</option>
						<option value="1"
							${! empty search.searchCondition && search.searchCondition==1 ? "selected" : "" }>��ǰ��</option>
						<option value="2"
							${! empty search.searchCondition && search.searchCondition==2 ? "selected" : "" }>��ǰ����</option>
				</select> <input type="text" name="searchKeyword" class="ct_input_g"
					value="${! empty search.searchKeyword ? search.searchKeyword : "
					" }"
						style="width: 200px; height: 19px"></td>

				<td align="right" width="70">
					<table border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td width="17" height="23"><img src="/images/ct_btnbg01.gif"
								width="17" height="23"></td>
							<td background="/images/ct_btnbg02.gif" class="ct_btn01"
								style="padding-top: 3px;">�˻�</td>
							<td width="14" height="23"><img src="/images/ct_btnbg03.gif"
								width="14" height="23"></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>


		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			style="margin-top: 10px;">
			<tr>
				<td colspan="11">��ü ${resultPage.totalCount } �Ǽ�, ����
					${resultPage.currentPage } ������</td>
			</tr>
			<tr>
				<td class="ct_list_b" width="100">No</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">��ǰ��</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b" width="150">����</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">�����</td>
				<td class="ct_line02"></td>
				<td class="ct_list_b">�������</td>
			</tr>
			<tr>
				<td colspan="11" bgcolor="808285" height="1"></td>
			</tr>

			<c:set var="i" value="0" />
			<c:forEach var="product" items="${list}">
				<c:set var="i" value="${ i+1 }" />
				<tr class="ct_list_pop">
					<td align="center">${ i }</td>
					<td></td>
					<td align="left" data-prodno="${product.prodNo}" data-trancode="${product.proTranCode}">${product.prodName}</td>

					<td></td>
					<td align="left">${product.price}</td>
					<td></td>
					<td align="left">${product.regDate}</td>
					<td></td>
					<td align="left" data-prodno="${product.prodNo}"><c:if test="${param.menu=='manage'}">
							<c:if
								test="${empty product.proTranCode || product.proTranCode == '   '}">
		�Ǹ���
	</c:if>
							<c:if test="${product.proTranCode == '1  '}">
		���ſϷ�  (����ϱ�)
							</c:if>
							<c:if test="${product.proTranCode == '2  '}">
		�����
	</c:if>
							<c:if test="${product.proTranCode == '3  '}">
		��ۿϷ�
	</c:if>
						</c:if> <c:if test="${param.menu=='search'}">
							<c:if
								test="${empty product.proTranCode||product.proTranCode == '   '}">
		�Ǹ���
	</c:if>
							<c:if
								test="${product.proTranCode == '1  '||product.proTranCode == '2  '||product.proTranCode == '3  '}">
		�������
	</c:if>
						</c:if></td>
				</tr>
				<tr>
					<td colspan="11" bgcolor="D6D7D6" height="1"></td>
				</tr>
			</c:forEach>
		</table>

		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			style="margin-top: 10px;">
			<tr>
				<td align="center"><input type="hidden" id="currentPage"
					name="currentPage" value="" /> <jsp:include
						page="../common/pageNavigator.jsp" /></td>
			</tr>
		</table>
		<!--  ������ Navigator �� -->

		</form>

	</div>
</body>
</html>