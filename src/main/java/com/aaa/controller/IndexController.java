package com.aaa.controller;

import com.aaa.entity.EmpFunction;
import com.aaa.entity.EmployeeInfo;
import com.aaa.service.EmployeeInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/26 9:35
 * @Description:
 */
@Controller
public class IndexController {

    private Logger logger= LoggerFactory.getLogger(IndexController.class);

    @Autowired
    private EmployeeInfoService employeeInfoService;

    //用户登录
    @RequestMapping("/login")
    @ResponseBody
    public String doLogin(String empNo, String empPwd, HttpSession session){
        EmployeeInfo employeeInfo=employeeInfoService.getEmpByLogin(empNo,empPwd);
        if (employeeInfo!=null){
            session.setAttribute("emp",employeeInfo);
            return "true";
        }
        return "false";
    }

    //用户退出登录
    @RequestMapping("/logout")
    @ResponseBody
    public String Logout(HttpSession session){
        EmployeeInfo employeeInfo=(EmployeeInfo)session.getAttribute("emp");
        if (employeeInfo!=null){
            //将session中的值移除
            session.removeAttribute("emp");
            session.invalidate();
            return "true";
        }
        return "false";
    }

    //用户更改密码
    @RequestMapping("/updPwd")
    public  String UpdatePwd(){
        return "updatePwd";
    }

    //检查旧密码是否正确
    @RequestMapping("/checkPwd")
    @ResponseBody
    public Object checkPwd(String oldpwd,HttpSession session){
        EmployeeInfo employeeInfo=(EmployeeInfo) session.getAttribute("emp");
        String pwd=employeeInfoService.getPwdById(employeeInfo.getEmpId());
        if (oldpwd!=null && oldpwd.equals(pwd))
            return "true";
        else
            return "false";
    }

    //确认更改密码
    @RequestMapping("/modifyPwd")
    @ResponseBody
    public Object modifyPwd(String newPwd,HttpSession session){
        EmployeeInfo employeeInfo=(EmployeeInfo) session.getAttribute("emp");
        boolean flag=employeeInfoService.modifyPwd(employeeInfo.getEmpId(),newPwd);
        if (flag)
            return "true";
        return "false";
    }

    //用户基本数据
    @RequestMapping("/getEmployeeInfo")
    public String getEmployeeInfo(HttpSession session, Model model){
        EmployeeInfo employeeInfo=(EmployeeInfo) session.getAttribute("emp");
        Map map=employeeInfoService.getEmpInfoById(employeeInfo.getEmpId());
        model.addAttribute("map",map);
        return "employeeInfo";
    }

    //登录成功后进入后端主页
    @RequestMapping("/backmain")
    public String toBackMain(){
        return "backIndex";
    }

    //异步获取左边功能导航框
    @RequestMapping("/getmenus")
    @ResponseBody
    public Object getMenus(HttpSession session){
        Integer roleId=((EmployeeInfo)session.getAttribute("emp")).getRoleId();
        //System.out.println("=============role"+roleId);
        List<EmpFunction> empFunctions=employeeInfoService.getMenus(roleId);
        return empFunctions;
    }

    //进入供应商信息操作页面
    @RequestMapping("/providerinfo")
    public String toprovider()
    {
        return "provider/providerInfo";
    }

    //进入员工信息操作页面
    @RequestMapping("/empinfo")
    public String toEmpInfo(){
        return "emp/empinfo";
    }

    //进入商品信息操作页面
    @RequestMapping("/productinfo")
    public String toProductInfo(){
        return "product/productInfo";
    }

    //进入客户信息操作页面
    @RequestMapping("/customerinfo")
    public String toCustomerInfo(){
        return "customer/customerInfo";
    }

    //加载申请采购订单页面
    @RequestMapping("/addpurchase")
    public String toPurchase(){
        return "purchase/addpurchase";
    }

    //加载采购订单页面
    @RequestMapping("/purchaselist")
    public String toPurchaseList(){
        return "purchase/purchaselist";
    }

    //查询采购订单信息
    @RequestMapping("/findPurchase")
    public String toFindPurchase(){
        return "purchase/findPurchase";
    }


    //点击左边功能导航框，加载相应的页面数据
    @RequestMapping("/tomain")
    public String toMain(){
        return "main";
    }

    //入库查询
    @RequestMapping("depotInList")
    public String toDepotInList(){
        return "depotIn/depotInList";
    }

    //采购订单查询
    @RequestMapping("findpurchase")
    public String toindPurcfhase(){
        return "purchase/purchaseLists";
    }


    //PJX
    //加载入库退货页面
    @RequestMapping("/returnpurchase")
    public String toReturnPurchase(){
        return "return/purchasereturn";
    }

    @RequestMapping("/returnsale")
    public String toReturnsale(){
        return "return/salereturn";
    }

    //加载库存调拨页面
    @RequestMapping("/repository")
    public String repositoryChange(){
        return "repository/repository";
    }
    //加载统计供应商页面
    @RequestMapping("/findProvider")
    public String findProvider(){
        return "find/findProvider";
    }
    //加载统计商品页面
    @RequestMapping("/findProduct")
    public String findProduct(){
        return "find/findProduct";
    }
    //加载统计客户页面
    @RequestMapping("/findCustomer")
    public String findCustomer(){
        return "find/findCustomer";
    }

}
