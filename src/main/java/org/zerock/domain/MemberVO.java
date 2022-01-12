package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
//회원정보(기본권한)
    private String userid;
    private String userpw;
    private String userName;
    private boolean enabled;
    
    private Date regDate;
    private Date updateDate;
    private List<AuthVO> authList; //여러개의 사용자 권한
}