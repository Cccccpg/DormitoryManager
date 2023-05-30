package com.CPG.dao;

import com.CPG.domain.Dorm;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface DormDao {

    /**
     * 查询所有宿舍信息
     */
    @Select("select * from dorms")
    List<Dorm> findAll() throws Exception;

    /**
     * 模糊查询宿舍信息
     */
    @Select("select * from dorms where dorm_id like '%${keyword}%' or dorm_intro like '%${keyword}%' or dorm_rps like '%${keyword}%' or dorm_leader like '%${keyword}%' or teacher like '%${keyword}%' ")
    List<Dorm> search(@Param(value = "keyword") String keyword) throws Exception;

    /**
     * 添加宿舍
     */
    @Insert("insert into dorms(dorm_id,dorm_intro,dorm_rps,dorm_leader,teacher) values(#{dorm_id},#{dorm_intro},#{dorm_rps},#{dorm_leader},#{teacher})")
    void add(Dorm dorm) throws Exception;

    /**
     * 更新宿舍信息
     */
    @Update("update dorms set dorm_id = #{dorm_id},dorm_intro = #{dorm_intro},dorm_rps = #{dorm_rps},dorm_leader = #{dorm_leader},teacher = #{teacher} where id = #{id}")
    void update(Dorm dorm) throws Exception;

    /**
     * 删除宿舍信息，一般不用此极端操作，更新宿舍信息即可
     */
    @Delete("delete from dorms where id = #{id}")
    void delete(String id) throws Exception;

    @Select("select * from dorms where dorm_id = #{dorm_id}")
    Dorm findByDormId(String dorm_id) throws Exception;

    @Select("select * from dorms where dorm_leader = #{dorm_leader}")
    Dorm findByDormLeader(String dorm_leader) throws Exception;

    @Select("select * from dorms where id = #{id}")
    Dorm findById(String id) throws Exception;

    @Select("select * from dorms where teacher = #{teacher}")
    List<Dorm> findByTeacher(String teacher) throws Exception;

}
