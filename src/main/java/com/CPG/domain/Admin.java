package com.CPG.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 管理员实体类
 * @author 陈品高
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Admin implements Serializable {
    private Integer id;         //id主键自增
    private String username;    //用户名
    private String password;    //密码
    private String name;        //姓名
    private String uid;         //学号或学工号
    private String phone;       //手机号
    private String email;       //邮箱
    private int power;          //是否开启权限
    private String description; //描述

}
