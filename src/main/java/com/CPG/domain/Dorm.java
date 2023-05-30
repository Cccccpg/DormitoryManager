package com.CPG.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 宿舍实体类
 * @author 陈品高
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Dorm implements Serializable {
    private Integer id;
    private String dorm_id;         //宿舍号
    private String dorm_intro;      //宿舍简介
    private String dorm_rps;        //宿舍荣誉
    private String dorm_leader;     //寝室长
    private String teacher;         //班主任

}
