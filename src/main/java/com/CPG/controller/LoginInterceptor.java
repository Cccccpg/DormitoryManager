package com.CPG.controller;

import com.CPG.domain.Admin;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LoginInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //获取请求的url
        String url = request.getRequestURI();
        //url：除了login.jsp是可以公开访问的，其余的url都要进行拦截
        if(url.toLowerCase().indexOf("login")>=0){
            return true;
        }
        HttpSession session = request.getSession();
        //获取Session中的用户登录信息
        Admin adminInfo =(Admin) session.getAttribute("adminInfo");
        //判断Session中是否有用户数据
        if(adminInfo != null){
            return true;
        }
        //地址栏不符合条件的直接重定向到登录页面
        response.sendRedirect("/hello/to_login");
        return false;
    }

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
