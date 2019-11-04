package com.aaa.service;

import com.aaa.dao.EmployeeInfoMapper;
import com.aaa.entity.EmpFunction;
import com.aaa.entity.EmployeeInfo;
import com.aaa.entity.EmployeeRole;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/26 9:33
 * @Description:实现EmployeeInfoService接口
 */
@Service
public class EmployeeInfoServiceImpl implements EmployeeInfoService {

    @Resource
    private EmployeeInfoMapper employeeInfoMapper;


    @Override
    public EmployeeInfo getEmpByLogin(String empNo, String empPwd) {
        return employeeInfoMapper.getEmpByLogin(empNo,empPwd);
    }

    @Override
    public String getPwdById(Integer empId) {
        return employeeInfoMapper.getPwdById(empId);
    }

    @Override
    public boolean modifyPwd(Integer empId, String newPwd) {
        int num=employeeInfoMapper.modifyPwd(empId, newPwd);
        if (num>0)
            return true;
        return false;
    }

    @Override
    public List<EmpFunction> getMenus(Integer roleId) {
        return employeeInfoMapper.getMenus(roleId);
    }

    @Override
    public int getEmpMaxId() {
        return employeeInfoMapper.getEmpMaxId();
    }

    @Override
    public List<Map> getEmpList(Map map) {
        List<Map> maps =employeeInfoMapper.getEmpList(map);

        return employeeInfoMapper.getEmpList(map);
    }

    @Override
    public int getEmpCount(Map map) {
        return employeeInfoMapper.getEmpCount(map);
    }

    @Override
    public List<EmployeeRole> getEmpRoleList() {
        return employeeInfoMapper.getEmpRoleList();
    }

    @Override
    public Map getEmpInfoById(Integer empId) {
        return employeeInfoMapper.getEmpInfoById(empId);
    }

    @Override
    public boolean addEmp(EmployeeInfo employeeInfo) {
        int num=employeeInfoMapper.addEmp(employeeInfo);
        if (num>0){
            return true;
        }
        return false;
    }

    @Override
    public boolean modifyEmp(EmployeeInfo employeeInfo) {
        int num=employeeInfoMapper.modifyEmp(employeeInfo);
        if (num>0){
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteEmp(Integer empId) {
        int num=employeeInfoMapper.deleteEmp(empId);
        if (num>0)
            return true;
        return false;
    }
}
