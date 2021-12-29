package org.zerock.service;

import java.util.Date;
import java.util.List;

import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.BoardAttachVO;

import lombok.Data;

public interface BoardService {
	public List<BoardVO> list(Criteria cri);
	public List<BoardVO> eachList(Criteria cri);
	public int totalCount(Criteria cri);
	public int etotalCount(Criteria cri);
	public void create(BoardVO vo);
	public BoardVO read(int bno);
	public int update(BoardVO vo);
	public int delete(int bno);
	public List<BoardAttachVO> getAttachList(int bno);
}
