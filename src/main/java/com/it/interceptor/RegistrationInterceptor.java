package com.it.interceptor;

import com.it.domain.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class RegistrationInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session=request.getSession();
        User user=(User) session.getAttribute("user");
        if(user!=null){
            return true ;
        }
        response.sendRedirect(request.getContextPath()+"/login/loginpages");
        return false;
    }
}
