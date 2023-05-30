package com.CPG.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

/**
 * 访客实体类
 * @author 陈品高
 */

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Visitor implements Serializable {

    private String id;          //全球唯一id UUID
    private String name;        //访客姓名
    private String sno;         //访客学号
    private String phone;       //电话号码
    private String place;       //访问住址
    private String begin_date;  //来访时间
    private String end_date;    //离开时间
    private String visit_result;//到访原因

}
