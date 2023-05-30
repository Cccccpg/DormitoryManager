package com.CPG.dao;

import com.CPG.domain.DormCheck;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DormCheckDao {

    /**
     * 查询所有查寝信息
     */
    @Select("select * from dorms_check")
    List<DormCheck> findAll() throws Exception;

    /**
     * 模糊查询宿舍信息
     */
    @Select("select * from dorms_check where dorm_id like '%${keyword}%' or dorm_checkdate like '%${keyword}%' or dorm_scores like '%${keyword}%' or dorm_leader like '%${keyword}%' or check_description like '%${keyword}%' ")
    List<DormCheck> search(@Param(value = "keyword") String keyword) throws Exception;

    /**
     * 添加宿舍
     */
    @Insert("insert into dorms_check(dorm_id,dorm_leader,dorm_checkdate,dorm_scores,check_description) values(#{dorm_id},#{dorm_leader},#{dorm_checkdate},#{dorm_scores},#{check_description})")
    void add(DormCheck dormCheck) throws Exception;

    /**
     * 更新宿舍信息
     */
    @Update("update dorms_check set dorm_id = #{dorm_id},dorm_leader = #{dorm_leader},dorm_checkdate = #{dorm_checkdate},dorm_scores = #{dorm_scores},check_description = #{check_description} where id = #{id}")
    void update(DormCheck dormCheck) throws Exception;

    /**
     * 删除宿舍信息，一般不用此极端操作，更新宿舍信息即可
     */
    @Delete("delete from dorms_check where id = #{id}")
    void delete(String id) throws Exception;

    @Select("select * from dorms_check where dorm_id = #{dorm_id}")
    DormCheck findByDormId(String dorm_id) throws Exception;

    @Select("select * from dorms_check where dorm_leader = #{dorm_leader}")
    DormCheck findByDormLeader(String dorm_leader) throws Exception;

    @Select("select * from dorms_check where dorm_checkdate = #{dorm_checkdate}")
    DormCheck findByCheckDate(String dorm_checkdate) throws Exception;

    @Select("select * from dorms_check where id = #{id}")
    DormCheck findById(String id) throws Exception;

    @Select("select * from dorms_check where dorm_leader = #{dorm_leader}")
    List<DormCheck> findByLeader(String leader) throws Exception;

    //保存数据到数据库的方法
    @Insert("insert into dorms_check(dorm_id,dorm_leader,dorm_checkdate,dorm_scores,check_description) values(#{dorm_id},#{dorm_leader},#{dorm_checkdate},#{dorm_scores},#{check_description})")
    boolean save(DormCheck dormCheck);

}
