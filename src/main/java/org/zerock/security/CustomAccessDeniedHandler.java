package org.zerock.security;
 
import java.io.IOException;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
 
import lombok.extern.log4j.Log4j;
 
@Log4j
// ��Ű�� , ���ǿ� Ư���� �۾��� �ϰų� , HttpServletResponse�� Ư���� ��������� �߰��Ұ�� ��ӹ޾� ����
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
 
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response,
            AccessDeniedException accessDeniedException) throws IOException, ServletException {
 
        log.error("Access denied handler");
        
        log.error("Redircet.......");
        
        //���� ���ѿ� �ɸ��� ��� �����̷�Ʈ�ϴ¹�� 
        response.sendRedirect("/accessError");
    }
 
}
 