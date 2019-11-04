package com.aaa.entity;

import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 16:09
 * 员工信息
 */
public class EmployeeInfo {

    private Integer empId ;//员工id
    private String empNo;//员工编号
    private String empPwd;//员工密码
    private String empName;//员工姓名
    private int empSex;//员工性别
    private String empPolitics;//员工政治面貌
    private Integer roleId;//角色
    private Date empBirthday;//生日日期
    private String empAddress;//员工地址
    private String empPostCode;//员工邮箱
    private String empPhone;//员工电话
    private String empEmail;//员工邮箱
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作
    private String empSexName;


    public String getEmpSexName() {
        return empSexName;
    }

    public void setEmpSexName(String empSexName) {
        this.empSexName = empSexName;
    }

    public Integer getEmpId() {
        return empId;
    }

    public void setEmpId(Integer empId) {
        this.empId = empId;
    }

    public String getEmpNo() {
        return empNo;
    }

    public void setEmpNo(String empNo) {
        this.empNo = empNo;
    }

    public String getEmpPwd() {
        return empPwd;
    }

    public void setEmpPwd(String empPwd) {
        this.empPwd = empPwd;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public int getEmpSex() {
        return empSex;
    }

    public void setEmpSex(int empSex) {
        this.empSex = empSex;
    }

    public String getEmpPolitics() {
        return empPolitics;
    }

    public void setEmpPolitics(String empPolitics) {
        this.empPolitics = empPolitics;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public Date getEmpBirthday() {
        return empBirthday;
    }

    public void setEmpBirthday(Date empBirthday) {
        this.empBirthday = empBirthday;
    }

    public String getEmpAddress() {
        return empAddress;
    }

    public void setEmpAddress(String empAddress) {
        this.empAddress = empAddress;
    }

    public String getEmpPostCode() {
        return empPostCode;
    }

    public void setEmpPostCode(String empPostCode) {
        this.empPostCode = empPostCode;
    }

    public String getEmpPhone() {
        return empPhone;
    }

    public void setEmpPhone(String empPhone) {
        this.empPhone = empPhone;
    }

    public String getEmpEmail() {
        return empEmail;
    }

    public void setEmpEmail(String empEmail) {
        this.empEmail = empEmail;
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
