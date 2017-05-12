<%@page import="java.io.File"%>
<%@page import="gallery.model.GalleryDAO"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@ include file="/inc/message.jsp" %>
<%! GalleryDAO dao = new GalleryDAO(); %>
<% 
	//클라이언트가 전송한 gallery_id 파라미터를 이용하여 db 1건 삭제 후, list.jsp 요청!
	String gallery_id = request.getParameter("gallery_id");
	String ext = request.getParameter("ext");
	int result = dao.delete(Integer.parseInt(gallery_id));
	
	if(result!=0){		
		//파일 삭제!!
		String realPath = application.getRealPath("/data");
		File file = new File(realPath+File.separator+gallery_id+"."+ext);
		if(file.delete()){
			out.print(showMsgURL("삭제 성공", "/board/list.jsp"));
		}
		
	}else{
		out.print(showMsgBack("삭제 실패"));
	}
	
	

%>