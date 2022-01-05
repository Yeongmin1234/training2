package org.zerock.domain;

import java.util.Date;

import org.apache.ibatis.annotations.Param;

import lombok.Data;

@Data
public class ReplyVO {
	
	private int rno;
	private int bno;
	
	private String reply;
	private String replyer;
	private Date replyDate;
	private Date updateDate;
	private int reparent;
    private int redepth;
    private int reorder;

}