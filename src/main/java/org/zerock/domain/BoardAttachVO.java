package org.zerock.domain;

import lombok.Data;

@Data
public class BoardAttachVO {
	public String uuid;//pk

	public String uploadpath;//���Ͼ��ε� ���
	
	public String filename;//�����̸�	
	
	private String filetype;//�̹��� ���� ����
	
	private int bno;//�Խ��� ��ȣ
	
}
