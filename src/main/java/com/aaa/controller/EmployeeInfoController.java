package com.aaa.controller;

import com.aaa.entity.EmployeeInfo;
import com.aaa.service.EmployeeInfoService;
import com.aaa.util.ResultMap;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/28 14:11
 * @Description:
 */
@Controller
@RequestMapping("/emp")
public class EmployeeInfoController {

    private Logger logger= LoggerFactory.getLogger(EmployeeInfoController.class);
    @Autowired
    private EmployeeInfoService employeeInfoService;

    //异步获取员工的信息
    @RequestMapping("/getEmpList")
    @ResponseBody
    public Object getEmpList(@RequestParam(value="page",required = false)Integer page,
                             @RequestParam(value="limit",required = false)Integer limit,
                             @RequestParam(value="empNo",required = false)String empNo,
                             @RequestParam(value="empName",required = false)String empName,
                             @RequestParam(value="roleId",required = false)Integer roleId){
        logger.info("page-"+page+"limit-"+limit+"empNo-"+empNo+"empName-"+empName+"roleId-"+roleId+"---------------");
        Map<String,Object> map=new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("empNo",empNo);
        map.put("empName",empName);
        map.put("roleId",roleId);
        List<Map> mapList=employeeInfoService.getEmpList(map);
        int count=employeeInfoService.getEmpCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    //异步获取员工的所有角色
    @RequestMapping("/getRoleList")
    @ResponseBody
    public Object getEmpRoleList(){
        return employeeInfoService.getEmpRoleList();
    }

    //进入添加操作页面
    @RequestMapping("/toAddEmp")
    public String toAddEmp(){

        return "emp/addemp";
    }
    //异步获取员工编号
    @RequestMapping("getEmpNo")
    @ResponseBody
    public Object getEmpNo(){
        String empNo=null;
        SimpleDateFormat sdf=new SimpleDateFormat("yyMM");
        int count=employeeInfoService.getEmpMaxId();
        if(count==0){
            empNo="NO"+sdf.format(new Date())+"001";
        }else
        if(count<10){
            empNo="NO"+sdf.format(new Date())+"00"+count;
        }else if(count<100){
            empNo="NO"+sdf.format(new Date())+"0"+count;
        }else{
            empNo="NO"+sdf.format(new Date())+count;
        }
        return empNo;
    }

    //保存添加的员工信息
    @RequestMapping("/addemp")
    @ResponseBody
    public Object saveAddEmp(EmployeeInfo employeeInfo){
        //System.out.println("-------"+employeeInfo.getEmpNo());
        employeeInfo.setEmpPwd(employeeInfo.getEmpNo());
        boolean flag=employeeInfoService.addEmp(employeeInfo);
        if (flag)
            return "true";
        return "false";
    }

    //进入员工信息修改页面
    @RequestMapping(value="/toModifyEmp/{empId}")
    public String toModifyEmp(Model model,@PathVariable Integer empId){
        //System.out.println("=======empId"+empId);
        Map map=employeeInfoService.getEmpInfoById(empId);
        model.addAttribute("emp",map);
        System.out.println("--------------empNO"+map.get("empNo"));
        return "emp/modifyemp";
    }

    //保存员工修改信息
    @RequestMapping("/modifyemp")
    @ResponseBody
    public Object saveModifyEmp(EmployeeInfo employeeInfo){
        //System.out.println("+++++++"+employeeInfo.getEmpId());
        boolean flag=employeeInfoService.modifyEmp(employeeInfo);
        if (flag){
            return "true";
        }
        return "false";
    }

    //通过员工id异步删除员工信息
    @RequestMapping("/deleteEmp")
    @ResponseBody
    public Object deleteEmpById(Integer empId){
        boolean flag=employeeInfoService.deleteEmp(empId);
        if (flag){
            return "true";
        }
        return "false";
    }

    //加载员工详细信息页面
    @RequestMapping(value="/showEmp/{empId}")
    public String showEmp(Model model,@PathVariable Integer empId){
        Map map=employeeInfoService.getEmpInfoById(empId);
        model.addAttribute("emp",map);
        return "emp/showemp";
    }
}
