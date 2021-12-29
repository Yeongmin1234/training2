package org.zerock.domain;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

@Data
@AllArgsConstructor
@Getter
public class ReplyPageDTO {
	// tbl_reply ���̺��� �ش� �Խù� ��ü �Ǽ�
	private int replyCnt;
	// tbl_reply ���̺��� �ش� �Խù��� ��� ����Ʈ
	private List<ReplyVO> list;
}