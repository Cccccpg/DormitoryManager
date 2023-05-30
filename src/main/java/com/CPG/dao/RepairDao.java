package com.CPG.dao;

import com.CPG.domain.Repair;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

public interface RepairDao {

    /**
     * 登记到访信息
     */
    @Insert("insert into repairs(id,name,sno,phone,dorm_id,repair_reason,repair_beginDate,repair_endDate) values(#{id},#{name},#{sno},#{phone},#{dorm_id},#{repair_reason},#{repair_beginDate},#{repair_endDate})")
    void add(Repair repair) throws Exception;

    /**
     * 按时间晚的优先显示查询所有访客记录
     */
    @Select("select * from repairs order by repair_beginDate desc")
    List<Repair> findAll() throws Exception;

    /**
     * 访客离开后修改报修结束时间（报修记录注销）
     */
    @Update("update repairs set repair_endDate = #{repair_endDate} where id = #{id}")
    void logout(@Param(value = "id") String id, @Param(value = "repair_endDate") String repair_endDate) throws Exception;

    /**
     * 根据关键字模糊查询报修记录，并按时间倒序排列
     */
    @Select("select * from repairs where name like '%${keyword}%' or sno like '%${keyword}%' or phone like '%${keyword}%' or dorm_id like '%${keyword}%' or repair_reason like '%${keyword}%' or repair_beginDate like '%${keyword}%' or repair_endDate like '%${keyword}%' order by repair_beginDate desc ")
    List<Repair> search(@Param(value = "keyword") String keyword) throws Exception;

}
