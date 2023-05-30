package com.CPG.controller;

import com.CPG.dao.AdminDao;
import com.CPG.domain.Admin;
import com.CPG.service.AdminService;
import com.CPG.utils.MD5Util;
import com.github.pagehelper.PageInfo;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;

@Controller
public class AdminController {
    private AdminService adminService;
    private AdminDao adminDao;
    @Autowired
    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }

    //处理用户登录请求
    @RequestMapping("/login")
    public String login(Model model, Admin admin, HttpSession session,
                        HttpServletRequest request, HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        if(admin == null || admin.getUsername() == null || admin.getPassword() == null){
            return "login";
        }
        admin.setPassword(MD5Util.MD5EncodeUtf8(admin.getPassword()));
        Admin ad = adminService.findAdmin(admin);
        if(ad != null){
            //登录信息存入session域
            session.setAttribute("adminInfo",ad);
            return "main";
        }
        model.addAttribute("msg","用户名或密码错误，请重新输入！");
        return "login";
    }

    //拦截后跳转至登录页
    @RequestMapping("/to_login")
    public String Login(){
        return "login";
    }

    //退出登录
    @RequestMapping("/loginOut")
    public String loginOut(Admin admin,Model model,HttpSession session){
        //通过session.invalidate()方法来注销当前的session
        session.invalidate();
        return "login";
    }

    //分页查询所有管理员信息
    @RequestMapping("/findAllAdmin")
    public ModelAndView findAll(@RequestParam(name = "page",required = true,defaultValue = "1")int page,
                                @RequestParam(name = "size",required = true,defaultValue = "10")int size,
                                HttpServletRequest request,HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        ModelAndView modelAndView = new ModelAndView();
        List<Admin> admins = null;
        String keyword = request.getParameter("keyword");
        if(keyword == null || keyword.trim().equals("") || keyword.length() == 0){
            admins = adminService.findAll(page,size);
        }else{
            admins = adminService.searchInfo(page,size,keyword);
        }
        //PageInfo就是一个封装了分页数据的bean
        PageInfo pageInfo = new PageInfo(admins);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.setViewName("admin-list");
        return modelAndView;
    }

    //删除管理员
    @ResponseBody
    @RequestMapping("/deleteAdmin")
    public void deleteAdmin(HttpServletRequest request) throws Exception{
        String id = request.getParameter("id");
        adminService.deleteAdminById(Integer.parseInt(id));
    }

    //检验用户名是否存在
    @RequestMapping("/checkUserName")
    public void checkUserName(HttpServletRequest request,HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter pw = response.getWriter();
        //取值
        String u_name = request.getParameter("u_name");
        //调用service，用户名存在返回true，不存在就返回false
        Boolean result = adminService.checkUserName(u_name);
        //回调函数
        if (result) {
            pw.write("账号可用");
        }else{
            pw.write("账号不存在");
        }
    }

    @RequestMapping("/adminAdd")
    public String adminAdd(){
        return "admin-add";
    }

    //添加管理员
    @RequestMapping("/addAdmin")
    public void addAdmin(Admin admin,HttpServletRequest request,HttpServletResponse response) throws Exception{
        PrintWriter writer = response.getWriter();
        Boolean check = adminService.checkUserName(admin.getUsername());
        if(check){
            writer.write("false");
            return;
        }
        if(admin == null){
            writer.write("false");
            return;
        }else{
            if(admin.getUsername() == null || "".trim().equals(admin.getUsername())
                    || admin.getPassword() == null ||"".trim().equals(admin.getPassword())
                    || admin.getName() == null || "".trim().equals(admin.getName())
                    || admin.getUid() == null || "".trim().equals(admin.getUid())
                    || admin.getPhone() == null || "".trim().equals(admin.getPhone())
                    || admin.getEmail() == null || "".trim().equals(admin.getEmail())
                    || admin.getDescription() == null || "".trim().equals(admin.getDescription())) {
                writer.write("false");
                return;
            }
        }
        Admin isNull = adminService.checkUid(admin.getUid());
        if(isNull != null){
            writer.write("false");
            return;
        }
        admin.setPassword(MD5Util.MD5EncodeUtf8(admin.getPassword()));
        adminService.addAdmin(admin);
        writer.write("true");
    }

    //跳转管理员信息编辑页面，并回显信息
    @RequestMapping("/adminEdit")
    public ModelAndView editAdmin(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        String id = request.getParameter("id");
        Admin ad = adminService.findAdminById(Integer.parseInt(id));
        mv.addObject("ad",ad);
        //mv.addObject("id",id);
        mv.setViewName("admin-edit");
        return mv;
    }
    //修改管理员信息
    @RequestMapping("/editAdmin")
    public void editAdmin(Admin admin,HttpServletResponse response) throws Exception {
        PrintWriter writer = response.getWriter();
        if (admin == null) {
            writer.write("false");
            return;
        }else {
            if(admin.getUsername() == null || "".trim().equals(admin.getUsername())
                    || admin.getName() == null || "".trim().equals(admin.getName())
                    || admin.getUid() == null || "".trim().equals(admin.getUid())
                    || admin.getPhone() == null || "".trim().equals(admin.getPhone())
                    || admin.getEmail() == null || "".trim().equals(admin.getEmail())
                    || admin.getDescription() == null || "".trim().equals(admin.getDescription())) {
                writer.write("false");
                return;
            }
        }
        //admin.setPassword(MD5Util.MD5EncodeUtf8(admin.getPassword()));
        adminService.updateAdmin(admin);
        //更新成功进行提示信息回显
        writer.write("true");
    }

    /**
     * 修改个人信息
     */
    @RequestMapping("/to_changeInfo")
    public String to_changeInfo(){
        return "changeInfo";
    }

    //修改个人信息
    @RequestMapping("/changeInfo")
    public void changeInfo(Admin admin,HttpServletResponse response) throws Exception {
        PrintWriter writer = response.getWriter();
        if (admin == null) {
            writer.write("false");
            return;
        }else {
            if(admin.getUsername() == null || "".trim().equals(admin.getUsername())
                    || admin.getPhone() == null || "".trim().equals(admin.getPhone())
                    || admin.getEmail() == null || "".trim().equals(admin.getEmail())) {
                writer.write("false");
                return;
            }
        }
        admin.setPassword(MD5Util.MD5EncodeUtf8(admin.getPassword()));
        adminService.updatePersonInfo(admin);
        //更新成功进行提示信息回显
        writer.write("true");
    }

    /**
     * 修改用户密码
     */
    @RequestMapping("/passwordEdit")
    public String editPassword(){
        return "admin-passwordEdit";
    }

    //修改用户密码
    @RequestMapping("/editPassword")
    public void passwordEdit(Admin admin,HttpServletResponse response,HttpServletRequest request) throws Exception {
        PrintWriter writer = response.getWriter();
        if (admin == null) {
            writer.write("false");
            return;
        }else {
            if(admin.getUsername() == null || "".trim().equals(admin.getUsername())
                    || admin.getName() == null || "".trim().equals(admin.getName())
                    || admin.getUid() == null || "".trim().equals(admin.getUid())
                    || admin.getPhone() == null || "".trim().equals(admin.getPhone())
                    || admin.getEmail() == null || "".trim().equals(admin.getEmail())) {
                writer.write("false");
                return;
            }
        }
        admin.setPassword(MD5Util.MD5EncodeUtf8(admin.getPassword()));
        adminService.updatePassword(admin);
        //更新成功进行提示信息回显
        writer.write("true");
    }

    /**
     * 授权操作
     */
    @RequestMapping("/put_power")
    public void put_power(Admin admin,HttpServletResponse response) throws Exception {
        PrintWriter writer = response.getWriter();
        if (admin == null) {
            writer.write("false");
            return;
        }
        if (admin.getPower() < 0 || admin.getPower() > 4) {
            writer.write("false");
            return;
        }
        adminService.put_power(admin);
        writer.write("true");
    }

    /**
     * 导出管理员信息
     */
    @RequestMapping("/exportAdminInfo")
    public void exportAdminInfo(HttpServletResponse response) throws Exception {
        InputStream is = adminService.getInputStream();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("contentDisposition", "attachment;filename=adminsInfo.xls");
        ServletOutputStream outputStream = response.getOutputStream();
        IOUtils.copy(is,outputStream);
    }


    /**
     * 校验学工号是否已被注册
     */
    @RequestMapping("/checkUid")
    public void checkUid(HttpServletRequest request,HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        String uid = request.getParameter("uid");
        Admin admin = adminService.checkUid(uid);
        if (admin != null) {
            writer.write("true");//uid已被注册
            return;
        }
    }


    //检验邮箱是否存在
    @RequestMapping("/checkEmail")
    public void checkEmail(HttpServletRequest request,HttpServletResponse response) throws Exception{
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter pw = response.getWriter();
        //取值
        String email = request.getParameter("email");
        //调用service，用户名存在返回true，不存在就返回false
        Boolean result = adminService.checkEmail(email);
        //回调函数
        if (result) {
            pw.write("邮箱可用");
        }else{
            pw.write("邮箱不存在");
        }
    }
}
