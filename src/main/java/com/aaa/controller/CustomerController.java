package com.aaa.controller;

import com.aaa.entity.CustomerInfo;
import com.aaa.service.CustomerInfoService;
import com.aaa.util.ResultMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/customer")
public class CustomerController {
    @Resource
    public CustomerInfoService customerInfoService;

    @RequestMapping("/getCustomerInfoList")
    @ResponseBody
    public Object getCustomerInfoList(@RequestParam(value="page",required = false)Integer page,
                                      @RequestParam(value="limit",required = false)Integer limit,
                                      @RequestParam(value="cusName",required = false)String cusName)
    {
        Map<String,Object> map=new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("cusName",cusName);
        List<Map> mapList=customerInfoService.getCustomerInfoList(map);
        int count=customerInfoService.getCustomerCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    @RequestMapping("/toAddCustomer")
    public String toAddCustomer()
    {
        return "customer/addcus";
    }

    @RequestMapping("/addcustomer")
    @ResponseBody
    public Object addcustomer(CustomerInfo customerInfo)
    {
        boolean flag=customerInfoService.addCustomerInfo(customerInfo);
        if (flag)
        {
            return true;
        }
        return false;
    }

    @RequestMapping("/showCustomerInfo/{cusId}")
    public String showCustomerInfo(Model model, @PathVariable int cusId)
    {
            model.addAttribute("customer",customerInfoService.getCustomerInfoById(cusId));
            return "customer/showcus";
    }

    @RequestMapping("/deleteCustomer")
    @ResponseBody
    public Object deleteCustomer(int cusId)
    {
        boolean flag=customerInfoService.deleteCustomer(cusId);
        if (flag)
        {
            return true;
        }
        return false;
    }

    @RequestMapping("/toModifyCustomer/{cusId}")
    public String toModifyCustomer(Model model,@PathVariable int cusId)
    {
        model.addAttribute("customer",customerInfoService.getCustomerInfoById(cusId));
        return "customer/modifycus";
    }

    @RequestMapping("/modifycustomer")
    @ResponseBody
    public Object modifycustomer(CustomerInfo customerInfo)
    {
        boolean flag=customerInfoService.modifycustomer(customerInfo);
        if (flag)
        {
            return true;
        }
        return false;
    }
}
