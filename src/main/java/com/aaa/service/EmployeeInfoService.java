package com.aaa.service;

import com.aaa.entity.EmpFunction;
import com.aaa.entity.EmployeeInfo;
import com.aaa.entity.EmployeeRole;

import java.util.List;
import java.util.Map;


/**
 * @Author: Peng
 * @Date: 2019/7/26 9:30
 * @Description:操作员工信息，service层
 */
public interface EmployeeInfoService {

    /*
     *通过员工账号和密码获取用户信息
     */
    public EmployeeInfo getEmpByLogin(String empNo, String empPwd);

    /*
     *通过员工id获取密码
     */
    public String getPwdById(Integer empId);

    /*
     *通过员工id更改员工密码
     */
    public boolean modifyPwd(Integer empId, String newPwd);

    /*
     *通过员工的角色id获取操作的权限功能
     */
    public List<EmpFunction> getMenus(Integer roleId);

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
    public Map getEmpInfoById(Integer empId);

    /*
    *添加一条员工的基本信息
     */
    public boolean addEmp(EmployeeInfo employeeInfo);

    /*
    *通过员工id对员工信息修改
     */
    public boolean modifyEmp(EmployeeInfo employeeInfo);

    /*
    *通过员工id删除员工信息
     */
    public boolean deleteEmp(Integer empId);

}
