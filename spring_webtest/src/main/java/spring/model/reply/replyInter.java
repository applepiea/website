package spring.model.reply;

import java.util.List;
import java.util.Map;

public interface replyInter {
	int create(ReplyDTO dto);
	ReplyDTO read(int rnum);
	int update(ReplyDTO dto);
	int delete(int rnum);
	List<ReplyDTO> list(Map map);
	int total(int bbsno);
	 int rcount(int bbsno);
	void bdelete(int bbsno);
}
