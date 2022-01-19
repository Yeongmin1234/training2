package org.zerock.security;
 
import java.io.IOException;
 
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
 
import lombok.extern.log4j.Log4j;
 
@Log4j
// 쿠키나 , 세션에 특정한 작업을 하거나 , HttpServletResponse에 특정한 헤더정보를 추가할경우 상속받아 구현
public class CustomAccessDeniedHandler implements AccessDeniedHandler {
 
    @Override
    public void handle(HttpServletRequest request, HttpServletResponse response,
            AccessDeniedException accessDeniedException) throws IOException, ServletException {
 
        log.error("Access denied handler");
        
        log.error("Redircet.......");
        
        //접근 제한에 걸리는 경우 리다이렉트하는방식 
        response.sendRedirect("/accessError");
    }
 
}
 