package spring.model.imgup;

import java.util.List;
import java.util.Map;

public interface ImgupInter {

	ImgUpDTO read(int imgno);
	Map imgread(int imgno);
	void upViewcnt(int imgno);
	int update(ImgUpDTO dto);
	int create(ImgUpDTO dto);
	int delete(ImgUpDTO dto);
	List<ImgUpDTO> list(Map map);
	int total(Map map);
	int Viewcnt(int imgno);
	int passwdCheck(Map map);
	int updateFile(Map map);

}
