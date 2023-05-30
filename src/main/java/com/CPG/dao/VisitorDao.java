package com.CPG.dao;


import com.CPG.domain.Visitor;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Description:访客持久层
 */
@Repository
public interface VisitorDao {

    /**
     * 登记到访信息
     */
    @Insert("insert into visitors(id,name,sno,phone,place,begin_date,end_date,visit_result) values(#{id},#{name},#{sno},#{phone},#{place},#{begin_date},#{end_date},#{visit_result})")
    void add(Visitor visitor) throws Exception;

    /**
     * 按时间晚的优先显示查询所有访客记录
     */
    @Select("select * from visitors order by begin_date desc")
    List<Visitor> findAll() throws Exception;

    /**
     * 访客离开后修改离开时间（访客记录注销）
     */
    @Update("update visitors set end_date = #{end_date} where id = #{id}")
    void logout(@Param(value = "id") String id, @Param(value = "end_date") String end_date) throws Exception;

    /**
     * 根据关键字模糊查询访客记录，并按时间倒序排列
     */
    @Select("select * from visitors where name like '%${keyword}%' or sno like '%${keyword}%' or phone like '%${keyword}%' or place like '%${keyword}%' or begin_date like '%${keyword}%' or end_date like '%${keyword}%' or visit_result like '%${keyword}%' order by begin_date desc ")
    List<Visitor> search(@Param(value = "keyword") String keyword) throws Exception;

}
