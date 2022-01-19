package org.zerock.domain;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class BoardVO {
	private int rownum;	   
	private int bno;	   
	private String title;  
	private	String text;   
	private String writer; 
	private Date date;	   
	private Date updateDate;	   
	private int replyCnt;
	private int hit;
	private int cate;
	private int pin;
	private int file;
	private List<BoardAttachVO> AttachList;
	
}
