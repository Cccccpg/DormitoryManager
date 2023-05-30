package com.CPG.service;

import com.CPG.dao.RepairDao;
import com.CPG.domain.Repair;
import com.CPG.poi.WriteExcel;
import com.github.pagehelper.PageHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;

@Service("repairService")
public class RepairServiceImpl implements RepairService {

    private RepairDao repairDao;

    @Autowired
    public void setRepairDao(RepairDao repairDao) {
        this.repairDao = repairDao;
    }

    /**
     * 登记报修信息
     */
    @Override
    public void add(Repair repair) throws Exception {
        repairDao.add(repair);
    }

    /**
     * 按时间晚的优先显示查询所有报修记录
     */
    @Override
    public List<Repair> findAll(int page, int size) throws Exception {
        PageHelper.startPage(page,size);
        return repairDao.findAll();
    }

    /**
     * 根据关键字模糊查询报修记录，并按时间倒序排列
     */
    @Override
    public List<Repair> search(int page, int size, String keyword) throws Exception {
        PageHelper.startPage(page,size);
        return repairDao.search(keyword);
    }

    /**
     * 报修结束后修改报修时间报修注销）
     */
    @Override
    public void logout(String id, String repair_endDate) throws Exception {
        repairDao.logout(id,repair_endDate);
    }

    /**
     * 导出报修记录
     */
    @Override
    public InputStream getInputStream() throws Exception {
        //Excel中的每列列名，依次对应数据库的字段
        String[] title = new String[]{"ID","姓名","学号","联系方式","报修地址","报修原因","报修时间","结束时间"};
        List<Repair> repairs = repairDao.findAll();
        List<Object[]> datalist = new ArrayList<>();
        for (int i = 0; i < repairs.size(); i++) {
            Object[] obj = new Object[8];
            obj[0] = repairs.get(i).getId();
            obj[1] = repairs.get(i).getName();
            obj[2] = repairs.get(i).getSno();
            obj[3] = repairs.get(i).getPhone();
            obj[4] = repairs.get(i).getDorm_id();
            obj[5] = repairs.get(i).getRepair_reason();
            obj[6] = repairs.get(i).getRepair_beginDate();
            obj[7] = repairs.get(i).getRepair_endDate();
            datalist.add(obj);
        }
        WriteExcel excel = new WriteExcel(title,datalist);
        return excel.export();
    }

    /**
     * 访客日志
     */
    @Override
    public List<Repair> log(int page,int size) throws Exception {
        PageHelper.startPage(page,size);
        return repairDao.findAll();
    }
}
