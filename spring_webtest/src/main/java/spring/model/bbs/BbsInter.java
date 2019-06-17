package spring.model.bbs;

import java.util.List;
import java.util.Map;

public interface BbsInter {

	int create(BbsDTO dto);
	BbsDTO read(int bbsno);
	int update(BbsDTO dto);
	int delete(int bbsno);
	List<BbsDTO> list(Map map);
	int total(Map map);
	BbsDTO readReply(int bbsno);
	void upAnsnum(Map map);
	int createReply(BbsDTO dto);
	int passCheck(Map map);
	int refnumCheck(int bbsno);
	void Viewcnt(int bbsno);
	int bdelete(int bbsno);
	
	
}
