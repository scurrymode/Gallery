<%@ page contentType="text/html;charset=utf-8"%>
<%! 
	//메세지 출력 메서드 정의
	
	//1.성공후 원하는 URL 요청
	public String showMsgURL(String msg, String url){
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("location.href='"+url+"';");
		sb.append("</script>");
		return sb.toString();
	}
	
	//2.실패후 뒤로가기
	public String showMsgBack(String msg){
		StringBuffer sb = new StringBuffer();
		sb.append("<script>");
		sb.append("alert('"+msg+"');");
		sb.append("history.back();");
		sb.append("</script>");
		return sb.toString();
	}	
%>