package common.file;

public class FileManager {
	
	//확장자 추출하기
	public static String getExt(String path){
		// a.b.c.d.jpg라도 먹히게
		int lastIndex = path.lastIndexOf(".");
		return path.substring(lastIndex+1, path.length());
	}

}
