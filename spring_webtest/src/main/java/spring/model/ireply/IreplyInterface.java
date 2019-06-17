package spring.model.ireply;

import java.util.List;
import java.util.Map;

public interface IreplyInterface {
	
	int create(IreplyDTO dto);
	IreplyDTO read(int inum);
	int update(IreplyDTO dto);
	int delete(int irnum);
	List<IreplyDTO> list(Map map);
	int total(int imgno);
	 int rcount(int imgno);

}
