<%@page import="common.file.FileManager"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="org.apache.commons.io.FileUtils"%>
<%@page import="java.io.File"%>
<%@page import="org.apache.commons.io.FilenameUtils"%>
<%@page import="gallery.model.Gallery"%>
<%@page import="gallery.model.GalleryDAO"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.disk.DiskFileItemFactory"%>
<%@page import="org.omg.PortableInterceptor.DISCARDING"%>
<%@page import="org.apache.commons.fileupload.servlet.ServletFileUpload"%>
<%@ page contentType="text/html;charset=utf-8"%>
<%@include file="/inc/message.jsp" %>
<%! GalleryDAO dao = new GalleryDAO(); %>
    
<%
	/*넘겨받는 파라미터 */ 
	ServletFileUpload upload = new ServletFileUpload(new DiskFileItemFactory());
	List<FileItem> list = upload.parseRequest(request); //요청분석
	Gallery dto = new Gallery();
	FileItem fileitem=null;
	
	//파라미터 갯수만큼 반복문 돌리면서, 파일인지 아닌지 조건을 따져봄
	for(int i=0; i<list.size();i++){
		FileItem item = list.get(i);
		
		if(item.isFormField()){
			//text parameter
			String name = item.getFieldName();
			out.print("html name is "+name+"<br>");
			String value = item.getString("utf-8");
			out.print(value);
			
			switch(item.getFieldName()){
				case "writer" : dto.setWriter(value); break;
				case "title" : dto.setTitle(value); break;
				case "content" : dto.setContent(value); break;
			}
		}else{
			//file parameter
			fileitem=item;
			String user_filename=item.getName();
			dto.setUser_filename(user_filename);			
		}
	}
	
	//요청을 보내자~!
	int result = dao.insert(dto);
	
	//방금 insert된 레코드가 사용하는 시퀀스 값을 파일 명에 적용해보자~!
	InputStream is = fileitem.getInputStream();
	String realPath = application.getRealPath("/data");
	//업로드된 파일명으로 부터 확장자명 구하기
	
	String ext = FileManager.getExt(dto.getUser_filename());
	String filename= result+"."+ext;
	
	String path = realPath+File.separator+filename;
	FileOutputStream fos = new FileOutputStream(path);
	
	byte[] b = new byte[1024];
	
	int flag=0;
	while(true){
		flag = is.read(b);
		if(flag==-1)break;
		fos.write(b);
	}
	if(fos!=null){
		fos.close();
	}
	if(is!=null){
		is.close();
	}
	
	
	if(result!=0){
		out.print(showMsgURL("등록성공", "/board/list.jsp"));
	}else{
		out.print(showMsgBack("등록실패"));
	}
%>