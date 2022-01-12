package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.Criteria;
import org.zerock.domain.ReplyVO;

public interface ReplyMapper {

	public List<ReplyVO> selectAll();
	public int insert(ReplyVO vo);	 
	public ReplyVO read(int rno);	 
	public int delete(int rno);
	public int update(ReplyVO vo);
	public int delUpdate(ReplyVO vo);
	public List<ReplyVO> getList(@Param("cri") Criteria cri,	
			   					@Param("bno") int bno);
	public List<ReplyVO> getListWithPaging(@Param("cri") Criteria cri,	
										   @Param("bno") int bno);
	public int getCountByBno(int bno);
	public int getCountByRno(int rno);
	public void deleteAll(long bno);
}