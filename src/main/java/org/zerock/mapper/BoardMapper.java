package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;


public interface BoardMapper {
	public List<BoardVO> list(Criteria cri);
	public List<BoardVO> pinList(Criteria cri);
	public List<BoardVO> eachList(Criteria cri);
	public List<BoardVO> pinEachList(Criteria cri);
	public int totalCount(Criteria cri);
	public int etotalCount(Criteria cri);
	public void create(BoardVO vo);
	public BoardVO read(int bno);
	public int update(BoardVO vo);
	public int delete(int bno);
	public void updateHit(int bno);
	public void updateReplyCnt(@Param("bno") int bno, @Param("amount") int amount);
}
