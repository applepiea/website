package spring.model.reply;

import static org.junit.Assert.assertTrue;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import test.ReplyInterTest;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations ={
		"file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
			})


public class replyInterTest {
	
	private static final Logger logger = LoggerFactory.getLogger(ReplyInterTest.class);

	@Autowired
	private replyInter inter;
	
	@Test
	@Ignore
	public void testMapper() {
		logger.info("mapper:"+inter.getClass().getName());
	}
	
	@Test
	@Ignore
	public void testCreate() {
	ReplyDTO dto=new ReplyDTO();
	dto.setBbsno(2);
	dto.setContent("댓글1");
	dto.setId("user2");
	
	assertTrue(inter.create(dto)>0);
	
		//fail("Not yet implemented");
	}

	@Test
	//@Ignore
		public void testRead() {
		ReplyDTO dto=inter.read(3);
		logger.info("dto:"+dto);
		//fail("Not yet implemented");
	}

	@Test
	@Ignore
	public void testUpdate() {
		ReplyDTO dto=new ReplyDTO();
		dto.setContent("댓글 2로 변경");
		dto.setRnum(4);
		assertTrue(inter.update(dto)>0);
		
		//fail("Not yet implemented");
	}

	@Test
	public void testDelete() {
		int rnum=4;
		assertTrue(inter.delete(rnum)>0);
		//fail("Not yet implemented");
	}

	@Test
	public void testList() {
		Map map=new HashMap();
		map.put("bbsno", 2);
		map.put("sno", 1);
		map.put("eno", 5);
		List<ReplyDTO> list =inter.list(map);
		logger.info("list:"+list);
				//fail("Not yet implemented");
	}

	@Test
	@Ignore
	public void testTotal() { //rcount와 같음
		int bbsno = 2; //글번호
		int cnt=inter.total(bbsno);
		logger.info("total:"+cnt);
		//fail("Not yet implemented");
	}
	
	@Test
	@Ignore
	public void testBdelete() throws Exception{
		int bbsno=2;
	}

	@Test
	public void testRcount() {
		//fail("Not yet implemented");
	}

}
