package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private int rownum;
	private int bno;	   //pk
	private String title;  //����
	private	String text;   //����
	private String writer; //�ۼ���
	private Date date;	   //�ۼ�����
	private int replyCnt;
	private int hit;
	private String cate;
	private List<BoardAttachVO> AttachList;
}
