package gallery.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import pool.PoolManager;

public class GalleryDAO {
	PoolManager pool = PoolManager.getInstance();

	// insert
	public int insert(Gallery dto) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		String sql = "insert into gallery(gallery_id, writer, title, content, user_filename)";
		sql += " values(seq_gallery.nextval, ?, ?, ?, ?)";
		try {
			con = pool.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, dto.getWriter());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getUser_filename());
			
			int exe = pstmt.executeUpdate();
			if(exe!=0){
				sql = "select seq_gallery.currval as seq from dual";
				pstmt=con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				if(rs.next()){
					result=rs.getInt("seq");
				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return result;
	}
	
	//모든 레코드 가져오기
	public List select(){
		ArrayList<Gallery> list = new ArrayList<Gallery>();
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		
		try {
			con = pool.getConnection();
			String sql = "select * from gallery order by gallery_id desc";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				Gallery dto = new Gallery();
				dto.setContent(rs.getString("content"));
				dto.setGallery_id(rs.getInt("gallery_id"));
				dto.setHit(rs.getInt("hit"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setTitle(rs.getString("title"));
				dto.setUser_filename(rs.getString("user_filename"));
				dto.setWriter(rs.getString("writer"));
				
				list.add(dto);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return list;		
	}
	
	//선택한 레코드 가져오기
	public Gallery select(int gallery_id){
		
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		Gallery dto = null;
		
		try {
			con = pool.getConnection();
			String sql = "select * from gallery where gallery_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gallery_id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				dto = new Gallery();
				dto.setContent(rs.getString("content"));
				dto.setGallery_id(rs.getInt("gallery_id"));
				dto.setHit(rs.getInt("hit"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setTitle(rs.getString("title"));
				dto.setUser_filename(rs.getString("user_filename"));
				dto.setWriter(rs.getString("writer"));
			}			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt, rs);
		}
		return dto;		
	}
	
	//레코드 한건 삭제
	public int delete(int gallery_id){
		Connection con =null;
		PreparedStatement pstmt= null;
		int result=0;		
		try {
			con=pool.getConnection();
			String sql = "delete from gallery where gallery_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, gallery_id);
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			pool.freeConnection(con, pstmt);
		}
		return result;
	}
}
