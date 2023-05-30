package com.CPG.domain;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.io.Serializable;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class DormCheck implements Serializable {

    @ExcelProperty("ID")
    private int id;
    @ExcelProperty("宿舍号")
    private String dorm_id;
    @ExcelProperty("宿舍长")
    private String dorm_leader;
    @ExcelProperty("查寝日期")
    private String dorm_checkdate;
    @ExcelProperty("查寝分数")
    private int dorm_scores;
    @ExcelProperty("I查寝详情")
    private String check_description;

}
