package com.aaa.entity;

import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 17:18
 * 入库商品总表
 */
public class DepotInMaster {

    private Integer depotInId;//入库id
    private String depotInNo;//入库编号
    private int empId;//员工id
    private String depotInUnit;//进货单位
    private Date depotInTime;//进货时间
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作


    public Integer getDepotInId() {
        return depotInId;
    }

    public void setDepotInId(Integer depotInId) {
        this.depotInId = depotInId;
    }

    public String getDepotInNo() {
        return depotInNo;
    }

    public void setDepotInNo(String depotInNo) {
        this.depotInNo = depotInNo;
    }

    public int getEmpId() {
        return empId;
    }

    public void setEmpId(int empId) {
        this.empId = empId;
    }

    public String getDepotInUnit() {
        return depotInUnit;
    }

    public void setDepotInUnit(String depotInUnit) {
        this.depotInUnit = depotInUnit;
    }

    public Date getDepotInTime() {
        return depotInTime;
    }

    public void setDepotInTime(Date depotInTime) {
        this.depotInTime = depotInTime;
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
