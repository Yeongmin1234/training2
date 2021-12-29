package org.zerock.domain;

import org.springframework.web.util.UriComponentsBuilder;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria { // 데이터로 정보를 보냄
	private int pageNum;
	private int amount;
	private String type;
	private String keyword;
	private String cate;
	
	public Criteria() {		// 생성자를 이용한 초기화
		this(1, 15);		// 초기화가 되었기 때문에 초기화면은 1페이지의 게시글 10가 자동으로 설정 됨
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