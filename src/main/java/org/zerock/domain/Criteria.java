package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria { // �����ͷ� ������ ����
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	private String cate;
	
	public Criteria() {		// �����ڸ� �̿��� �ʱ�ȭ
		this(1, 15);		// �ʱ�ȭ�� �Ǿ��� ������ �ʱ�ȭ���� 1�������� �Խñ� 10�� �ڵ����� ���� ��
	}
	
	public Criteria(int pageNum, int amount) {
		this.pageNum = pageNum;
		this.amount = amount;
	}
	public String getListlink() {
		UriComponentsBuilder builder=UriComponentsBuilder.fromPath("")
				.queryParam("cate", this.getCate())
				.queryParam("pageNum", this.pageNum)
				.queryParam("amount", this.getAmount())
				.queryParam("type", this.getType())
				.queryParam("keyword", this.getKeyword());
		return builder.toString();
			
		}
	
}