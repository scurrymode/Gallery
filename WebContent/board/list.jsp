<%@page import="common.file.FileManager"%>
<%@page import="java.io.File"%>
<%@page import="gallery.model.Gallery"%>
<%@page import="java.util.List"%>
<%@page import="gallery.model.GalleryDAO"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%! GalleryDAO dao = new GalleryDAO(); %>
<% List<Gallery> list = dao.select(); %>
<%
//페이징 처리 변수
	int currentPage = 1; //다섯번째, 블럭을 넘길려다보니 지금 어느 페이지인지 확인해야함!
	if(request.getParameter("currentPage")!=null){
		currentPage=Integer.parseInt(request.getParameter("currentPage")); //이걸 제대로 했는지 보기 위해서 스타일을 준다.
	}
	int totalRecord = list.size(); //첫번째, 총 레코드 수
	int pageSize = 10; //두번째, 한 페이지당 보여줄 레코드 수
	int totalPage = (int)Math.ceil((float)totalRecord/pageSize);//세번째, 전체 페이지 갯수
	int blockSize = 10; //네번째, 블럭당 보여질 페이지 수(총 레코드가 많으면 문제!)
	int firstPage = currentPage-(currentPage-1)%blockSize;//여섯번째, 해당 블럭의 첫번째 페이지, current가 14이면 11
	int lastPage = firstPage+blockSize-1; //일곱번째, 해당 블럭의 마지막 페이지 이걸해야 화살표의 움직임을 정하고, 눌렀을때, 띄울 블락을 특정할 수 있당~!
	//여덟번째, 블럭의 for문에 break; 걸고 i랑 totalPage비교해서
	int curPos=(currentPage-1)*10; //열한번째, db에서 뽑아와서 레코드가 띄워지게 할 페이지별 index를 알아야하니깐~! 페이지당 시작 index
	int num = totalRecord-curPos;//아홉번째, 페이지당 시작번호
	//열번째, 레코드별 숫자부여하고, 레코드 for문에서 num이 1보다 작을때는 break;
	
	
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<style>
#box{border:1px solid #CCCCCC}
#title{font-size:9pt;font-weight:bold;color:#7F7F7F;돋움}
#category{font-size:9pt;color:#7F7F7F;돋움}
#keyword{
	width:80px;
	height:17px;
	font-size:9pt;
	border-left:1px solid #333333;
	border-top:1px solid #333333;
	border-right:1px solid #333333;
	border-bottom:1px solid #333333;
	color:#7F7F7F;돋움
}
#paging{font-size:9pt;color:#7F7F7F;돋움}
#list td{font-size:9pt;}
#copyright{font-size:9pt;}
a{text-decoration:none}
img{border:0px}
.pageStyle{
	font-size:17pt;
	color:blue;
	font-weight:bold;
}
</style>
</head>
<body>
<table id="box" align="center" width="603" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td colspan="6"><img src="/board/images/ceil.gif" width="603" height="25"></td>
  </tr>
  <tr>
    <td height="2" colspan="6" bgcolor="#6395FA"><img src="/board/images/line_01.gif"></td>
  </tr>
  <tr id="title" align="center">
    <td width="50" height="20">번호</td>
    <td width="50" height="20">이미지</td>
    <td width="303" height="20">제목</td>
    <td width="100" height="20">글쓴이</td>
    <td width="100" height="20">날짜</td>
    <td width="50" height="20">조회수</td>
  </tr>
  <tr>
    <td height="1" colspan="6" bgcolor="#CCCCCC"></td>
  </tr>
	<tr>	
		<td colspan="6" id="list">
		  <table width="100%" border="0" cellpadding="0" cellspacing="0">
		  <% for(int i=1; i<=pageSize; i++){ %> 
		  <% if(num<1)break; %>
		  <% Gallery dto = list.get(curPos++); %>
		    <tr align="center" height="20px" onMouseOver="this.style.background='#FFFF99'" onMouseOut="this.style.background=''">
			  <td width="50"><%=num-- %></td>
			  <td width="50"><img src="/data/<%=dto.getGallery_id()+"."+FileManager.getExt(dto.getUser_filename()) %>" width="45"></td>
			  <td width="303"><a href="detail.jsp?gallery_id=<%=dto.getGallery_id()%>"><%= dto.getTitle()%></a></td>
			  <td width="100"><%= dto.getWriter()%></td>
			  <td width="100"><%= dto.getRegdate().substring(0, 10)%></td>
			  <td width="50">5</td>
		    </tr>
			<tr>
				<td height="1" colspan="6" background="/board/images/line_dot.gif"></td>
			</tr>
			<%} %>
			  
		    </table>		</td>
	</tr>
  <tr>
    <td id="paging" height="20" colspan="6" align="center">
    ◀
    <% for(int i=firstPage; i<=lastPage;i++){%>
    <% if(i>totalPage)break; %>
    <a <% if(currentPage==i){%>class="pageStyle" <%} %>href="/board/list.jsp?currentPage=<%=i%>">[<%=i %>]</a>
    <% } %>
   <a href="/board/list.jsp?currentPage=<%=lastPage+1 %>" >▶</a>
    </td>
  </tr>
  <tr>
    <td height="20" colspan="6" align="right" style="padding-right:2px;">
	<table width="160" border="0" cellpadding="0" cellspacing="0">
      <tr>
        <td width="70">
          <select name="select" id="category">
            <option>제목</option>
            <option>내용</option>
            <option>글쓴이</option>
          </select>        </td>
        <td width="80">
          <input name="textfield" id="keyword" type="text" size="15">        </td>
        <td><img src="/board/images/search_btn.gif" width="32" height="17"></td>
      </tr>
    </table></td>
  </tr>
  <tr>
    <td height="30" colspan="6" align="right" style="padding-right:2px;"><a href="write.jsp"><img src="/board/images/write_btin.gif" width="61" height="20" border="0"></a></td>
  </tr>
  <tr>
    <td height="1" colspan="6" bgcolor="#CCCCCC"></td>
  </tr>
  
  	<%@ include file="/inc/bottom.jsp" %>
  	
</table>
</body>
</html>
