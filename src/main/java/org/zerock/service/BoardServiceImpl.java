package org.zerock.service;

import java.io.File;
import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.BoardVO;
import org.zerock.domain.Criteria;
import org.zerock.domain.BoardAttachVO;
import org.zerock.mapper.BoardMapper;
import org.zerock.mapper.ReplyMapper;
import org.zerock.mapper.BoardAttachMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService {
	public BoardMapper mapper;
	private BoardAttachMapper attachMapper;
	private ReplyMapper replyMapper;
	@Override
	public List<BoardVO> list(Criteria cri) {
		return mapper.list(cri);
	}
	@Override
	public List<BoardVO> pinList(Criteria cri) {
		return mapper.pinList(cri);
	}
	@Override
	public List<BoardVO> eachList(Criteria cri) {
		return mapper.eachList(cri);
	}
	
	@Override
	public List<BoardVO> pinEachList(Criteria cri) {
		return mapper.pinEachList(cri);
	}
	
	@Override
	public int totalCount(Criteria cri) {
		return mapper.totalCount(cri);
	}
	@Override
	public int etotalCount(Criteria cri) {
		return mapper.etotalCount(cri);
	}
	@Override
	public void create(BoardVO vo) {
		
		mapper.create(vo);
		
		if(vo.getAttachList()==null || vo.getAttachList().size()<=0 ) {
			return;
		}
		vo.getAttachList().forEach(attach->{
				//파일정보           =BoardAttachVO
			attach.setBno(vo.getBno());
			attachMapper.insert(attach);
		});
	}
	
	@Override
	@Transactional
	public BoardVO read(int bno) {
		System.out.println("이상없음");
		mapper.updateHit(bno);
		return mapper.read(bno);
	}

	@Override
	public int update(BoardVO vo) {
		
		attachMapper.deleteAll(vo.getBno());
		
		int modifyResult = mapper.update(vo);
		
		if(modifyResult==1 && vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			
			vo.getAttachList().forEach(attach -> {
				System.out.println("이거 실행 됨");
				attach.setBno(vo.getBno());
				attachMapper.insert(attach);
			});
		}
		System.out.println("위에꺼 실행 안됨");
		return modifyResult;
	}

	@Override
	public int delete(int bno) {
		attachMapper.deleteAll(bno);
		replyMapper.deleteAll(bno);
		return mapper.delete(bno);
	}

	public List<BoardAttachVO> getAttachList(int bno) {
		return attachMapper.findByBno(bno);
	}
	


}
