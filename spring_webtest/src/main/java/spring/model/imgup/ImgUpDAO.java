package spring.model.imgup;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import spring.utility.webtest.DBClose;
import spring.utility.webtest.DBOpen;


@Repository
public class ImgUpDAO {
	
	public boolean updateFile(Map<String, String> map) {
		
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		
		int imgno = Integer.parseInt(map.get("imgno"));
		String fname = (String)map.get("fname");
		
		StringBuffer sql = new StringBuffer();
		sql.append(" update image ");
		sql.append(" set fname = ? ");
		sql.append(" where imgno = ? ");
	
		try {
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setString(1, fname);
			pstmt.setInt(2, imgno);
			
			int cnt = pstmt.executeUpdate();
			if(cnt>0) flag=true;
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			DBClose.close(con, pstmt);
		}
		return flag;
		
	}
	
	public void upViewcnt(int imgno) {
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		StringBuffer sql = new StringBuffer();
		
		sql.append(" update image ");
		sql.append(" set viewcnt = viewcnt + 1 ");
		sql.append(" where imgno = ? ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			DBClose.close(con, pstmt);
		}
	
	
	}

	public boolean passwdCheck(Map map) {
		
		boolean flag = false;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		int imgno =(Integer)map.get("imgno");
		String passwd = (String)map.get("passwd");
		StringBuffer sql = new StringBuffer();
		sql.append(" select count(*) from image ");
		sql.append(" where imgno = ? ");
		sql.append(" and passwd= ? ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);
			pstmt.setString(2, passwd);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				
				int cnt = rs.getInt(1);
				
				if(cnt>0)flag=true;
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			DBClose.close(con, pstmt, rs); 
		}
		
		return flag;
	}
	
	
	public boolean create(ImgUpDTO dto) {

		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" insert into image (imgno,name, title, content, ");
		sql.append(" regdate, passwd, viewcnt, fname) ");
		sql.append(" values(");
		sql.append(" (select nvl(max(imgno),0)+1 from image), ");
		sql.append(" ?, ?, ?, sysdate, ?, ?, ?) ");

		try {

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTitle());
			pstmt.setString(3, dto.getContent());
			pstmt.setString(4, dto.getPasswd());
			pstmt.setInt(5, dto.getViewcnt());
			pstmt.setString(6, dto.getFname());

			int cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;

	}

	public ImgUpDTO read(int imgno) {

		ImgUpDTO dto = null;
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		StringBuffer sql = new StringBuffer();
		sql.append(" select imgno, name, title, content, regdate, fname, ");
		sql.append(" passwd, viewcnt ");
		sql.append(" from image ");
		sql.append(" where imgno = ? ");

		try {
			
			pstmt=con.prepareStatement(sql.toString());
			pstmt.setInt(1, imgno);

			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				
				dto = new ImgUpDTO();
				
				dto.setImgno(rs.getInt("imgno"));
				dto.setName(rs.getString("name"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setRegdate(rs.getString("regdate"));
				dto.setPasswd(rs.getString("passwd"));
				dto.setViewcnt(rs.getInt("viewcnt"));
				dto.setFname(rs.getString("fname"));
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			DBClose.close(con, pstmt);
		}
		return dto;

	}

	public boolean update(ImgUpDTO dto) {

		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" update image ");
		sql.append(" set title = ? , ");
		sql.append("    content = ? , ");
		sql.append("    fname = ? ");
		sql.append(" where imgno = ? ");

		try {

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setString(1, dto.getTitle());
			pstmt.setString(2, dto.getContent());
			pstmt.setString(3, dto.getFname());
			pstmt.setInt(4, dto.getImgno());
			
			int cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;

	}
	
	public int total(Map map) {
		
		int total=0;
		
		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String col = (String)map.get("col");
		String word = (String)map.get("word");
		
		StringBuffer sql = new StringBuffer();
		
		sql.append(" select count(*) from member ");
		
		if(word.trim().length()>0)
		sql.append("  where \"+col+\" like '%'||?||'%' ");
		
		try {
			pstmt=con.prepareStatement(sql.toString());
			
			if(word.trim().length()>0)
				pstmt.setString(1, word);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				total=rs.getInt(1);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			DBClose.close(con, pstmt, rs);
		}
		
		return total;
	}
	

	public List<ImgUpDTO> list(Map map) {

		List<ImgUpDTO> list = new ArrayList<ImgUpDTO>();

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String col = (String) map.get("col");
		String word = (String) map.get("word");
		int sno = (Integer) map.get("sno");
		int eno = (Integer) map.get("eno");

		StringBuffer sql = new StringBuffer();

		sql.append(" select imgno,name, title, content, regdate, passwd, viewcnt, fname, r ");
		sql.append(" from( select imgno,name, title, content, regdate, passwd, viewcnt, fname, rownum r ");
		sql.append("      from( ");
		sql.append("            select imgno,name, title, content, regdate, passwd, viewcnt, fname ");
		sql.append("            from image ");

		if (word.trim().length() > 0)
			sql.append("             where \"+col+\" like '%'||?||'%' ");
		sql.append("            order by imgno desc ");
		sql.append("            ) ");
		sql.append("    ) where r>= ? and r <= ? ");

		try {

			int i = 0;
			pstmt = con.prepareStatement(sql.toString());

			if (word.trim().length() > 0)
				pstmt.setString(++i, word);
				pstmt.setInt(++i, sno);
				pstmt.setInt(++i, eno);

				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					
					ImgUpDTO dto = new ImgUpDTO();
					dto.setImgno(rs.getInt("imgno"));
					dto.setName(rs.getString("name"));
					dto.setTitle(rs.getString("title"));
					dto.setContent(rs.getString("content"));
					dto.setRegdate(rs.getString("regdate"));
					dto.setPasswd(rs.getString("passwd"));
					dto.setViewcnt(rs.getInt("viewcnt"));
					dto.setFname(rs.getString("fname"));
					
					list.add(dto);
				}
				
		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			DBClose.close(con, pstmt, rs);
		}

		return list;

	}

	public boolean delete(int imgno) {

		boolean flag = false;

		Connection con = DBOpen.open();
		PreparedStatement pstmt = null;

		StringBuffer sql = new StringBuffer();
		sql.append(" delete from image ");
		sql.append(" where imgno = ? ");

		try {

			pstmt = con.prepareStatement(sql.toString());

			pstmt.setInt(1, imgno);

			int cnt = pstmt.executeUpdate();

			if (cnt > 0)
				flag = true;

		} catch (Exception e) {
			e.printStackTrace();
			// TODO: handle exception
		} finally {
			DBClose.close(con, pstmt);
		}

		return flag;

	}

}
