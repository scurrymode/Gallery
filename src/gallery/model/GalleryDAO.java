package gallery.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

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

}
