package com.CPG.dao;

import com.CPG.domain.Admin;
import org.apache.ibatis.annotations.*;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 持久层
 */

@Repository
public interface AdminDao {

    //通过用户名密码查询用户信息
    @Select("select * from admins where username = #{username} and password = #{password}")
    Admin findAdmin(Admin admin) throws Exception;

    //通过id查询用户信息
    @Select("select * from admins where id = #{id}")
    Admin findAdminById(Integer id) throws Exception;

    //分页查询所有管理员信息
    @Select("select * from admins")
    List<Admin> findAll() throws Exception;

    //导出管理员信息
    @Select("select * from admins")
    List<Admin> exportAdminInfo() throws Exception;

    //根据id删除管理员信息
    @Delete("delete from admins where id = #{id}")
    void deleteAdminById(Integer id) throws Exception;

    //修改管理员信息
    @Update("update admins set username = #{username},name = #{name},uid = #{uid},phone = #{phone},email = #{email},description = #{description} where id = #{id}")
    void updateAdmin(Admin admin) throws Exception;

    //修改个人信息
    @Update("update admins set username = #{username},phone = #{phone},email = #{email},password = #{password} where uid = #{uid}")
    void updatePersonInfo(Admin admin) throws Exception;

    //添加管理员信息
    @Insert("insert into admins(username,password,name,uid,phone,email,power,description) values(#{username},#{password},#{name},#{uid},#{phone},#{email},#{power},#{description})")
    void addAdmin(Admin admin) throws Exception;

    //检验用户名是否存在
    @Select("select * from admins where username = #{u_name}")
    Boolean checkUserName(String u_name) throws Exception;

    //检验学工号是否已被注册
    @Select("select * from admins where uid = #{uid}")
    Admin checkUid(String uid) throws Exception;

    //修改密码
    @Update("update admins set username = #{username},password = #{password},name = #{name},phone = #{phone},email = #{email} where uid = #{uid}")
    void updatePassword(Admin admin) throws Exception;

    //模糊搜索管理员信息，查询结果返回一个list集合
    @Select("select * from admins where username like '%${keyword}%' or name like '%${keyword}%' or uid like '%${keyword}%' or phone like '%${keyword}%'or email like '%${keyword}%' or power like '%${keyword}%' or description like '%${keyword}%' ")
    List<Admin> searchInfo(@Param(value = "keyword") String keyword) throws Exception;

    //管理员授权     等级：0 1 2 3 4
    @Update("update admins set power = #{power} where id = #{id}")
    void put_power(Admin admin) throws Exception;

    //检验邮箱是否存在
    @Select("select * from admins where email = #{email}")
    Boolean checkEmail(String email) throws Exception;


}
