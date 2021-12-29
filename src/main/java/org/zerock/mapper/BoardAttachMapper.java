package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.BoardAttachVO;

public interface BoardAttachMapper {
	// ���� ���ε��� �������� tbl_attach���̺� insert��
	public void insert(BoardAttachVO vo);
	// ���� ���ε��� �������� tbl_attach���̺� delete��
	public void delete(String uuid);
	// ���� ���ε��Ѱ͵��� ����ڰ� �� �� �ֵ��� ȭ�鿡 ��ȸ�� �� �ֵ��� ��.
	public List<BoardAttachVO> findByBno(int bno);
	
	public void deleteAll(long bno);
}