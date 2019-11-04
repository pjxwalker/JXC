package com.aaa.dao;

import com.aaa.entity.EmpFunction;
import com.aaa.entity.EmployeeInfo;
import com.aaa.entity.EmployeeRole;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/25 22:02
 * @Description:对员工表操作，持久层
 */
public interface EmployeeInfoMapper {
    /*
    *通过员工账号和密码获取用户信息
     */
    public EmployeeInfo getEmpByLogin(@Param("empNo") String empNo, @Param("empPwd") String empPwd);

    /*
    *通过员工id获取密码
     */
    public String getPwdById(@Param("empId") Integer empId);

    /*
    *通过员工id更改员工密码
     */
    public int modifyPwd(@Param("empId") Integer empId, @Param("newPwd") String newPwd);

    /*
    *通过员工的角色id获取操作的权限功能
     */
    public List<EmpFunction> getMenus(@Param("roleId") Integer roleId);

    /*
    *获取员工表中最的empId
     */
    public int getEmpMaxId();

    /*
     *获取员工的所有基本信息
     */
    public List<Map> getEmpList(Map map);

    /*
    *获取员工表中一共有多少条数据
     */
    public int getEmpCount(Map map);

    /*
     *获取所有员工的角色信息
     */
    public List<EmployeeRole> getEmpRoleList();

    /*
    *根据员工id获取员工详细信息
     */
    public Map getEmpInfoById(@Param("empId") Integer empId);

    /*
    *添加一条员工的基本信息
     */
    public int addEmp(EmployeeInfo employeeInfo);

    /*
    *通过id修改员工的基本信息
     */
    public int modifyEmp(EmployeeInfo employeeInfo);

    /*
    *通过id删除员工的基本信息
     */
    public int deleteEmp(@Param("empId") Integer empId);
}
