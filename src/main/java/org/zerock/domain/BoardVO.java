package org.zerock.domain;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private int rownum;	   //pk
	private int bno;	   //pk
	private String title;  //����
	private	String text;   //����
	private String writer; //�ۼ���
	private Date date;	   //�ۼ�����
	private int replyCnt;
	private int hit;
	private int cate;
	private int pin;
	private int file;
	private List<BoardAttachVO> AttachList;
	
}
