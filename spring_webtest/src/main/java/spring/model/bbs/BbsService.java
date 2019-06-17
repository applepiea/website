package spring.model.bbs;

import java.sql.Connection;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import spring.model.reply.replyInter;
import spring.utility.webtest.DBOpen;

@Service
public class BbsService {

	@Autowired
	private BbsInter inter;
	@Autowired
	private replyInter rinter;

	public void delete(int bbsno) throws Exception {
		
		// 자식레코드 삭제(댓글 삭제)
		// 부모레코드 삭제(글 삭제)
		rinter.bdelete(bbsno);
		inter.delete(bbsno);

	}

	public void reply(BbsDTO dto) throws Exception {

		Map map = new HashMap();
		map.put("grpno", dto.getGrpno());
		map.put("ansnum", dto.getAnsnum());

		inter.upAnsnum(map);
		inter.createReply(dto);
	}

}