package com.CPG.controller;


import com.CPG.domain.Repair;
import com.CPG.service.RepairService;
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
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;


@Controller
@RequestMapping("/repair")
public class RepairController {

    private RepairService repairService;

    @Autowired
    public void setRepairService(RepairService repairService) {
        this.repairService = repairService;
    }

    @RequestMapping("/login")
    public String register() {
        return "regist_repair";
    }

    /**
     * 报修登记实现
     */
    @RequestMapping("/addLogin")
    public ModelAndView addRepair(Repair repair) throws Exception {
        ModelAndView mv = new ModelAndView();
        if (repair == null || repair.getName() == null || repair.getSno() == null || repair.getPhone() == null || repair.getDorm_id() == null) {
            mv.addObject("error_msg","报修登记失败，请重新登记！");
            mv.setViewName("regist_repair");
            return mv;
        }
        if (repair.getId() == null || "".trim().equals(repair.getId())) {
            String uuid = UUID.randomUUID().toString().replace("-", "");
            repair.setId(uuid);
        }
        String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        repair.setRepair_beginDate(date);//设置报修时间为提交报修登记时间
        //先设置离开时间为空串，后续注销时再修改为注销时系统时间
        if (repair.getRepair_endDate() == null || "".trim().equals(repair.getRepair_endDate())) {
            repair.setRepair_endDate("");
        }
        repairService.add(repair);
        mv.addObject("id",repair.getId());
        mv.setViewName("repair-success");
        return mv;
    }

    /**
     * 报修记录注销
     */
    @RequestMapping("/login_out")
    public ModelAndView logout(HttpServletRequest request) throws Exception {
        ModelAndView mv = new ModelAndView();
        String id = request.getParameter("id");
        if (id == null || "".trim().equals(id)) {
            mv.addObject("logout_msg","系统繁忙，请稍后再试！");
            mv.setViewName("regist_repair");
        }
        String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        repairService.logout(id,date);
        mv.addObject("logout_msg","注销成功");
        mv.setViewName("regist_repair");
        return mv;
    }

    /**
     * 管理员手动注销报修状态
     */
    @RequestMapping("/updateStatus")
    public void updateStatus(HttpServletRequest request,HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        PrintWriter writer = response.getWriter();
        String id = request.getParameter("id");
        if (id == null || "".trim().equals(id)) {
            writer.write("false");
            return;
        }
        String date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
        repairService.logout(id,date);
        writer.write("true");
    }

    /**
     * 查询所有报修记录
     */
    @RequestMapping("/findAll")
    public ModelAndView findAll(@RequestParam(name = "page", required = true, defaultValue = "1") int page, @RequestParam(name = "size", required = true, defaultValue = "10") int size,HttpServletRequest request,HttpServletResponse response) throws Exception {
        request.setCharacterEncoding("utf-8");
        response.setCharacterEncoding("utf-8");
        ModelAndView mv = new ModelAndView();
        List<Repair> repair = null;
        String keyword = request.getParameter("keyword");
        if (keyword == null || "".trim().equals(keyword) || keyword.length() == 0) {
            repair = repairService.findAll(page,size);
        }else {
            repair = repairService.search(page,size,keyword);
        }
        PageInfo pageInfo = new PageInfo(repair);
        mv.addObject("pageInfo",pageInfo);
        mv.setViewName("repair-list");
        return mv;
    }

    /**
     * 报修日志
     */
    @RequestMapping("/log")
    public ModelAndView log(@RequestParam(name = "page", required = true, defaultValue = "1") int page, @RequestParam(name = "size", required = true, defaultValue = "10") int size) throws Exception {
        ModelAndView mv = new ModelAndView();
        List<Repair> logs = repairService.log(page,size);
        PageInfo pageInfo = new PageInfo(logs);
        mv.addObject("pageInfo",pageInfo);
        mv.setViewName("repair-log");

        return mv;
    }
    /**
     * 导出报修信息
     */
    @RequestMapping("/repairInfo")
    public void export(HttpServletResponse response) throws Exception {
        InputStream is = repairService.getInputStream();
        response.setContentType("application/vnd.ms-excel");
        response.setHeader("contentDisposition","attachment;filename=repairInfo.xls");
        ServletOutputStream outputStream = response.getOutputStream();
        IOUtils.copy(is,outputStream);
    }
}
