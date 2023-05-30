package com.CPG.controller;

import com.CPG.domain.Admin;
import com.CPG.domain.Dorm;
import com.CPG.domain.DormCheck;
import com.CPG.domain.Student;
import com.CPG.service.AdminService;
import com.CPG.service.DormCheckService;
import com.CPG.service.DormService;
import com.CPG.service.StudentService;
import com.github.pagehelper.PageInfo;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;

@RequestMapping("/dormCheck")
@Controller
public class DormCheckController {

    private DormService dormService;
    private StudentService studentService;
    private AdminService adminService;
    private DormCheckService dormCheckService;

    @Autowired
    public void setDormCheckService(DormCheckService dormCheckService) {
        this.dormCheckService = dormCheckService;
    }

    @Autowired
    public void setStudentService(StudentService studentService) {
        this.studentService = studentService;
    }

    @Autowired
    public void setDormService(DormService dormService) {
        this.dormService = dormService;
    }

    @Autowired
    public void setAdminService(AdminService adminService) {
        this.adminService = adminService;
    }

    /**
     * 查询所有查寝信息
     */
    @RequestMapping("/findAllCheck")
    public ModelAndView findAllCheck(@RequestParam(name = "page",required = true,defaultValue = "1")int page,
                                @RequestParam(name = "size",required = true,defaultValue = "10")int size,
                                HttpServletRequest request, HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("utf-8");
        ModelAndView modelAndView = new ModelAndView();
        List<DormCheck> dormChecks = null;
        String keyword = request.getParameter("keyword");
        if(keyword == null || "".trim().equals(keyword)){
            dormChecks = dormCheckService.findAll(page,size);
        }else {
            dormChecks = dormCheckService.search(page,size,keyword);
        }
        PageInfo pageInfo = new PageInfo(dormChecks);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.setViewName("dorm-checkList");
        return modelAndView;
    }

    /**
     * 发布查寝结果
     */
    @RequestMapping("/publish")
    public ModelAndView publishCheck(@RequestParam(name = "page",required = true,defaultValue = "1")int page,
                                     @RequestParam(name = "size",required = true,defaultValue = "10")int size,
                                     HttpServletRequest request, HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("utf-8");
        ModelAndView modelAndView = new ModelAndView();
        List<DormCheck> dormChecks = null;
        String keyword = request.getParameter("keyword");
        if(keyword == null || "".trim().equals(keyword)){
            dormChecks = dormCheckService.findAll(page,size);
        }else {
            dormChecks = dormCheckService.search(page,size,keyword);
        }
        PageInfo pageInfo = new PageInfo(dormChecks);
        modelAndView.addObject("pageInfo",pageInfo);
        modelAndView.setViewName("dormCheck-publish");
        return modelAndView;
    }


    /**
     * 转发到添加查寝结果页面
     */
    @RequestMapping("/toAdd")
    public String addDormCheck() throws Exception{
        return "dormCheck-add";
    }

    /**
     * 添加查寝结果
     */
    @RequestMapping("/add")
    public void add(DormCheck dormCheck,HttpServletResponse response) throws Exception{
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        if (dormCheck == null || dormCheck.getDorm_id() == null || dormCheck.getDorm_leader() == null
                || dormCheck.getDorm_checkdate() == null  || dormCheck.getDorm_scores() == 0
                || dormCheck.getCheck_description() == null) {
            writer.write("false");
            return;
        }
        DormCheck isNull = dormCheckService.findByDormId(dormCheck.getDorm_id());
        if (isNull != null) {
            writer.write("false");
            return;
        }
        dormCheckService.add(dormCheck);
        writer.write("true");
    }

    /**
     * 通过宿舍号判断该宿舍是否存在,存在返回true
     */
    @RequestMapping("/isExistSameDorm_id")
    public void isExistSameDorm_id(HttpServletRequest request,HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        String dorm_id = request.getParameter("dorm_id");
        DormCheck isNull = dormCheckService.findByDormId(dorm_id);
        if (isNull != null) {
            writer.write("true");
            return;
        }
    }/**
     * 通过宿舍号判断该查寝日期是否存在,存在返回true
     */
    @RequestMapping("/isExistSameDormCheckDate")
    public void isExistSameDormCheckDate(HttpServletRequest request,HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        String dorm_id = request.getParameter("dorm_id");
        String dorm_checkdate = request.getParameter("dorm_checkdate");
        DormCheck isDorm_idNull = dormCheckService.findByDormId(dorm_id);
        DormCheck isDorm_checkdateNull = dormCheckService.findByCheckDate(dorm_checkdate);
        if (isDorm_idNull != null || isDorm_checkdateNull != null) {
            writer.write("true");
            return;
        }
    }

    /**
     * 判断该宿舍长是否存在,存在返回true
     */
    @RequestMapping("/isExistSameDorm_leader")
    public void isExistSameDorm_leader(HttpServletRequest request,HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        String dorm_leader = request.getParameter("dorm_leader");
        DormCheck isNull = dormCheckService.findByDormLeader(dorm_leader);
        if (isNull != null) {
            writer.write("true");
            return;
        }
    }

    /**
     * 通过id查询查寝信息用以修改查寝信息操作之前的信息回显
     */
    @RequestMapping("/toUpdate")
    public ModelAndView toUpdate(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        String id = request.getParameter("id");
        if (id == null) {
            return mv;
        }
        DormCheck dormCheck = dormCheckService.findById(id);
        mv.addObject("dormCheck",dormCheck);
        mv.setViewName("dormCheck-edit");

        return mv;
    }

    /**
     * 修改查寝信息
     */
    @RequestMapping("/update")
    public void update(DormCheck dormCheck,HttpServletResponse response) throws Exception {
        PrintWriter writer = response.getWriter();
        if (dormCheck == null || dormCheck.getDorm_id() == null || dormCheck.getDorm_leader() == null
                || dormCheck.getDorm_checkdate() == null || dormCheck.getDorm_scores() == 0
                || dormCheck.getCheck_description() == null) {
            writer.write("false");
            return;
        }
        dormCheckService.update(dormCheck);
        writer.write("true");
    }

    /**
     * 导出查寝信息
     */
    @RequestMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        InputStream is = dormCheckService.getInputStream();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("contentDisposition","attachment;filename=dormCheckInfo.xls");
        ServletOutputStream outputStream = response.getOutputStream();
        IOUtils.copy(is,outputStream);
    }

//    上传表格
//    @ResponseBody
//    @RequestMapping(value="/fileUpload.do", produces = "application/text; charset=utf-8")
//    public String UploadExcel(HttpServletRequest request,HttpServletResponse response) throws Exception {
//        return dormCheckService.ajaxUploadExcel(request, response);
//    }

    /**
     * 转发到详情页
     */
    @RequestMapping("/look")
    public ModelAndView look(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        DormCheck dormCheck = null;
        String id = request.getParameter("id");
        String uid = request.getParameter("uid");
        if (id == null && uid != null) {
            Student stu = studentService.findBySno(uid);
            dormCheck = dormCheckService.findByDormId(stu.getDorm_id());
        }else if (id != null) {
            dormCheck = dormCheckService.findById(id);
        }else {
            return mv;
        }
        mv.addObject("dormCheck",dormCheck);
        mv.setViewName("look-dormCheck");

        return mv;
    }

    /**
     * 宿舍学生信息
     */
    @RequestMapping("/byDorm_leader")
    public ModelAndView find(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        String uid = request.getParameter("uid");
        String dorm_id = request.getParameter("dorm_id");
        if (dorm_id != null) {
            List<Student> studentsInfo = studentService.findByDormId(dorm_id, 1);
            mv.addObject("studentsInfo",studentsInfo);
            mv.setViewName("dormStudentsInfo");
            return mv;
        }
        Student stu = studentService.findBySno(uid);
//        Dorm dormInfo = dormService.findByDormId(stu.getDorm_id());
        List<Student> studentsInfo = studentService.findByDormId(stu.getDorm_id(), 1);
//        mv.addObject("dormInfo",dormInfo);
        mv.addObject("studentsInfo",studentsInfo);
        mv.setViewName("dormStudentsInfo");

        return mv;
    }

    @RequestMapping("/byTeacher")
    public ModelAndView find1(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        String uid = request.getParameter("uid");
        Admin admin = adminService.checkUid(uid);
        List<Dorm> dorms = dormService.findByTeacher(admin.getName());
        mv.addObject("dorms",dorms);
        mv.setViewName("dormsTeacherInfo");
        return mv;
    }

    /**
     * 查询所有班主任为teacher的学生集合
     */
    @RequestMapping("/findStudent")
    public ModelAndView findStudents(@RequestParam(name = "page", required = true, defaultValue = "1")int page, @RequestParam(name = "size", required = true, defaultValue = "10") int size,HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        List<Student> students = null;
        String teacher = request.getParameter("name");
        String keyword = request.getParameter("keyword");
        System.out.println(keyword);
        if (keyword == null || "".trim().equals(keyword) || keyword.length() == 0) {
            students = studentService.findByTeacher(page,size,teacher);
        }
        if (keyword != null){
            students = studentService.searchStudent(page,size,teacher,keyword);
        }
        PageInfo pageInfo = new PageInfo(students);
        mv.addObject("pageInfo",pageInfo);
        mv.setViewName("studentsTeacher");

        return mv;
    }

}
