package com.CPG.controller;


import com.CPG.domain.Admin;
import com.CPG.domain.Dorm;
import com.CPG.domain.Student;
import com.CPG.service.AdminService;
import com.CPG.service.DormService;
import com.CPG.service.StudentService;
import com.github.pagehelper.PageInfo;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.List;


@RequestMapping("/dorm")
@Controller
public class DormController {

    private DormService dormService;
    private StudentService studentService;
    private AdminService adminService;

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
     * 查询所有宿舍信息
     */
    @RequestMapping("/findAll")
    public ModelAndView findAll(@RequestParam(name = "page", required = true, defaultValue = "1")int page, @RequestParam(name = "size", required = true, defaultValue = "10") int size, HttpServletRequest request, HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        ModelAndView mv = new ModelAndView();
        List<Dorm> dorms = null;
        String keyword = request.getParameter("keyword");
        if (keyword == null || "".trim().equals(keyword)) {
            dorms = dormService.findAll(page,size);
        }else {
            dorms = dormService.search(page,size,keyword);
        }
        PageInfo pageInfo = new PageInfo(dorms);
        mv.addObject("pageInfo",pageInfo);
        mv.setViewName("dorm-list");

        return mv;
    }

    /**
     * 转发到宿舍添加页面
     */
    @RequestMapping("/toAdd")
    public String addDorm() throws Exception {
        return "dorm-add";
    }
    /**
     * 添加宿舍
     */
    @RequestMapping("/add")
    public void add(Dorm dorm,HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        if (dorm == null || dorm.getDorm_id() == null || dorm.getDorm_intro() == null || dorm.getDorm_rps() == null
            || dorm.getDorm_leader() == null || dorm.getTeacher() == null) {
            writer.write("false");
            return;
        }
        Dorm isNull = dormService.findByDormId(dorm.getDorm_id());
        if (isNull != null) {
            writer.write("false");
            return;
        }
        dormService.add(dorm);
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
        Dorm isNull = dormService.findByDormId(dorm_id);
        if (isNull != null) {
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
        Dorm isNull = dormService.findByDormLeader(dorm_leader);
        if (isNull != null) {
            writer.write("true");
            return;
        }
    }

    /**
     * 通过id查询宿舍信息用以修改宿舍信息操作之前的信息回显
     */
    @RequestMapping("/toUpdate")
    public ModelAndView toUpdate(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
        ModelAndView mv = new ModelAndView();
        String id = request.getParameter("id");
        if (id == null) {
            return mv;
        }
        Dorm dorm = dormService.findById(id);
        mv.addObject("dorm",dorm);
        mv.setViewName("dorm-edit");

        return mv;
    }

    /**
     * 修改宿舍信息
     */
    @RequestMapping("/update")
    public void update(Dorm dorm,HttpServletResponse response) throws Exception {
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        if (dorm == null ||dorm.getId() == null || dorm.getDorm_id() == null || dorm.getDorm_intro() == null || dorm.getDorm_rps() == null
                || dorm.getDorm_leader() == null || dorm.getTeacher() == null) {
            writer.write("false");
            return;
        }
        dormService.update(dorm);
        writer.write("true");
    }

    /**
     * 导出宿舍信息
     */
    @RequestMapping("/export")
    public void export(HttpServletResponse response) throws Exception {
        InputStream is = dormService.getInputStream();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("contentDisposition","attachment;filename=dormInfo.xls");
        ServletOutputStream outputStream = response.getOutputStream();
        IOUtils.copy(is,outputStream);

    }

    /**
     * 转发到详情页
     */
    @RequestMapping("/look")
    public ModelAndView look(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        Dorm dorm = null;
        String id = request.getParameter("id");
        String uid = request.getParameter("uid");
        if (id == null && uid != null) {
            Student stu = studentService.findBySno(uid);
            dorm = dormService.findByDormId(stu.getDorm_id());
        }else if (id != null) {
            dorm = dormService.findById(id);
        }else {
            return mv;
        }
        mv.addObject("dorm",dorm);
        mv.setViewName("look-dorm");

        return mv;
    }

    /**
     * 宿舍学生信息
     */
    @RequestMapping("/byDorm_leader")
    public ModelAndView find(HttpServletRequest request) throws Exception {
        request.setCharacterEncoding("utf-8");
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
        List<Student> studentsInfo = studentService.findByDormId(stu.getDorm_id(), 1);
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
        request.setCharacterEncoding("utf-8");
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
