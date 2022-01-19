package org.zerock.security;
import java.sql.Connection;
import java.sql.PreparedStatement;
 
import javax.sql.DataSource;
 
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
 
import lombok.Setter;
import lombok.extern.log4j.Log4j;
 
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
  "file:src/main/webapp/WEB-INF/spring/root-context.xml",
  "file:src/main/webapp/WEB-INF/spring/security-context.xml"
  })
@Log4j
public class MemberTests {
 
  @Setter(onMethod_ = @Autowired)
  private PasswordEncoder pwencoder;
  
  @Setter(onMethod_ = @Autowired)
  private DataSource ds;
  
  @Test
  public void testInsertMember() {
	   
    String sql = "insert into board (title,text,writer,cate,pin,file) values(?,?,?,?,?,?)";
    
    for(int i = 11; i < 21; i++) {
      
      Connection con = null;
      PreparedStatement pstmt = null;
      
      try {
        con = ds.getConnection();
        pstmt = con.prepareStatement(sql);
          
          pstmt.setString(1, "테스트"+i);
          pstmt.setString(2,"테스트입니다"+i);
          pstmt.setString(3, "김영민");
          pstmt.setString(4, "3");
          pstmt.setString(5, "0");
          pstmt.setString(6, "0");

        
          pstmt.executeUpdate();
        
      }catch(Exception e) {
        e.printStackTrace();
      }finally {
        if(pstmt != null) { try { pstmt.close();  } catch(Exception e) {} }
        if(con != null) { try { con.close();  } catch(Exception e) {} }
        
      }
    }//end for
  }
}
