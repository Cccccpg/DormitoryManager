package com.CPG.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Repair implements Serializable {

    private String id;                  //全球唯一id UUID
    private String name;                //报修姓名
    private String sno;                 //报修学号
    private String phone;               //电话号码
    private String dorm_id;             //报修宿舍
    private String repair_reason;       //报修原因
    private String repair_beginDate;    //报修时间
    private String repair_endDate;      //解决时间
}
