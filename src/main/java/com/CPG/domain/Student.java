package com.CPG.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/***
 *学生实体类
 * @author 陈品高
 */

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Student implements Serializable {
    private Integer id;
    private String name;            //姓名
    private String sex;             //性别
    private String sno;             //学号
    private String stu_class;       //班级
    private String phone;           //电话号
    private String place;           //家庭住址
    private String dorm_id;         //宿舍号
    private String teacher;         //班主任
    private int status;             //学生状态 1：住校 0：不住校
}
