package com.CPG.service;

import com.CPG.dao.DormCheckDao;
import com.CPG.domain.DormCheck;
import com.CPG.poi.WriteExcel;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service("dormCheckService")
public class DormCheckServiceImpl implements DormCheckService{

    private DormCheckDao dormCheckDao;

    @Autowired
    public void setDormCheckDao(DormCheckDao dormCheckDao) {
        this.dormCheckDao = dormCheckDao;
    }

    /**
     * 查询所有查寝信息
     * @param page
     * @param size
     * @return
     * @throws Exception
     */
    @Override
    public List<DormCheck> findAll(int page, int size) throws Exception {
        PageHelper.startPage(page,size);
        return dormCheckDao.findAll();
    }

    /**
     * 根据keword关键字模糊查询
     * @param page
     * @param size
     * @param keyword
     * @return
     * @throws Exception
     */
    @Override
    public List<DormCheck> search(int page, int size, String keyword) throws Exception {
        PageHelper.startPage(page,size);
        return dormCheckDao.search(keyword);
    }

    /**
     * 添加查寝信息
     * @param dormCheck
     * @throws Exception
     */
    @Override
    public void add(DormCheck dormCheck) throws Exception {
        dormCheckDao.add(dormCheck);
    }

    /**
     * 更新查寝信息
     * @param dormCheck
     * @throws Exception
     */
    @Override
    public void update(DormCheck dormCheck) throws Exception {
        dormCheckDao.update(dormCheck);
    }

    /**
     * 导出查寝信息
     * @return
     * @throws Exception
     */
    @Override
    public InputStream getInputStream() throws Exception {
        //Excel中的每列列名，依次对应数据库的字段
        String[] title = new String[]{"ID","宿舍号","宿舍长","查寝日期","查寝分数","查寝详情"};
        List<DormCheck> dormsCheck = dormCheckDao.findAll();
        List<Object[]> datalist = new ArrayList<>();
        for (int i = 0; i < dormsCheck.size(); i++) {
            Object[] obj = new Object[6];
            obj[0] = dormsCheck.get(i).getId();
            obj[1] = dormsCheck.get(i).getDorm_id();
            obj[2] = dormsCheck.get(i).getDorm_leader();
            obj[3] = dormsCheck.get(i).getDorm_checkdate();
            obj[4] = dormsCheck.get(i).getDorm_scores();
            obj[5] = dormsCheck.get(i).getCheck_description();
            datalist.add(obj);
        }
        WriteExcel excel = new WriteExcel(title,datalist);
        return excel.export();
    }


    @Override
    public DormCheck findByDormId(String dorm_id) throws Exception {
        return dormCheckDao.findByDormId(dorm_id);
    }

    @Override
    public DormCheck findByDormLeader(String dorm_leader) throws Exception {
        return dormCheckDao.findByDormLeader(dorm_leader);
    }

    @Override
    public DormCheck findByCheckDate(String dorm_checkdate) throws Exception {
        return dormCheckDao.findByCheckDate(dorm_checkdate);
    }

    @Override
    public DormCheck findById(String id) throws Exception {
        return dormCheckDao.findById(id);
    }

    @Override
    public List<DormCheck> findByLeader(String leader) throws Exception {
        return dormCheckDao.findByLeader(leader);
    }

    @Override
    public boolean insert(DormCheck dormCheck) throws Exception {
        return dormCheckDao.save(dormCheck);
    }

//    @Override
//    public String ajaxUploadExcel(HttpServletRequest request,
//                                  HttpServletResponse response) throws Exception {
//        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
//
//        MultipartFile file = multipartRequest.getFile("upfile");
//        if(file.isEmpty()){
//            try {
//                throw new Exception("文件不存在！");
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        }
//
//        InputStream in =null;
//        try {
//            in = file.getInputStream();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//
//        List<List<Object>> listob = null;
//        try {
//            listob = new ExcelUtil().getBankListByExcel(in,file.getOriginalFilename());
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        //该处可调用service相应方法进行数据保存到数据库中，现只对数据输出
//        for (int i = 0; i < listob.size(); i++) {
//            List<Object> lo = listob.get(i);
//            DormCheck dormCheck = new DormCheck();
//            dormCheck.setDorm_id(String.valueOf(lo.get(1)));     // 表格的第一列   注意数据格式需要对应实体类属性
//            dormCheck.setDorm_leader(String.valueOf(lo.get(2)));
//            dormCheck.setDorm_checkdate(String.valueOf(lo.get(3)));
//            dormCheck.setDorm_scores(Integer.valueOf(String.valueOf(lo.get(4))));
//            dormCheck.setDorm_checkdate(String.valueOf(lo.get(5)));
//            dormCheckDao.save(dormCheck);
//        }
//        System.out.println("文件导入成功！");
//        return "文件导入成功！";
//    }
}
