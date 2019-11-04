package com.aaa.entity;

import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 17:18
 * 出库商品总表
 */
public class DepotOutMaster {

    private Integer depotOutId;//出库id
    private String depotOutNo;//出库编号
    private int empId;//员工id
    private int depotOutUnit;//进货单位
    private Date depotOutTime;//进货时间
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作


    public Integer getDepotOutId() {
        return depotOutId;
    }

    public void setDepotOutId(Integer depotOutId) {
        this.depotOutId = depotOutId;
    }

    public String getDepotOutNo() {
        return depotOutNo;
    }

    public void setDepotOutNo(String depotOutNo) {
        this.depotOutNo = depotOutNo;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public int getDepotOutUnit() {
        return depotOutUnit;
    }

    public void setDepotOutUnit(int depotOutUnit) {
        this.depotOutUnit = depotOutUnit;
    }

    public Date getDepotOutTime() {
        return depotOutTime;
    }

    public void setDepotOutTime(Date depotOutTime) {
        this.depotOutTime = depotOutTime;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
