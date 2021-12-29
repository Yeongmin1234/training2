package org.zerock.domain;

import lombok.Getter;
import lombok.ToString;

@Getter
@ToString
public class PageDTO {
	
	// ���� ������
	private int startPage;
	// ������ ������
	private int endPage;
	
	private int first;

	private int last;
	
	// ������ư, ������ư ǥ�� ����
	private boolean prev, next,firstPage,lastPage;
	// tbl_board ���̺��� ��ü ����
	private int total;
	// Criteria
	private Criteria cri;
	
	public PageDTO (Criteria cri, int total) {
		this.cri = cri;
		this.total = total;
		
		this.endPage=(int)(Math.ceil(cri.getPageNum()/5.0)) * 5;
		
		this.startPage = this.endPage - 4;
		
		int realEnd = (int)(Math.ceil(   (total * 1.0) / cri.getAmount()   ));
		
		if(realEnd < this.endPage) {
			this.endPage = realEnd;
		}
//		if
		this.first=1;
		this.last = realEnd;
		// ���� ��ư ����
		this.prev = this.startPage > 1;
		// ���� ��ư ����
		this.next = this.endPage < realEnd;
	}
}