package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private int rownum;
	private int bno;	   //pk
	private String title;  //제목
	private	String text;   //내용
	private String writer; //작성자
	private Date date;	   //작성일자
	private int replyCnt;
	private int hit;
	private String cate;
	private List<BoardAttachVO> AttachList;
}
