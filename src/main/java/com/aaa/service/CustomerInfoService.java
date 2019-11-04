package com.aaa.service;

import com.aaa.entity.CustomerInfo;

import java.util.List;
import java.util.Map;

public interface CustomerInfoService {
    /*
     *获取所有供应商基本信息
     */
    public List<Map> getCustomerInfoList(Map map);
    /*
     *根据条件获取满足条件供应商有多少条记录
     */
    public int getCustomerCount(Map map);
    /*
     *添加客户基本信息
     */
    public boolean addCustomerInfo(CustomerInfo customerInfo);
    /*
     *通过id获取客户详细信息
     */
    public CustomerInfo getCustomerInfoById(int cusId);
    /*
     *通过客户id对客户基本信息进行修改
     */
    public boolean modifycustomer(CustomerInfo customerInfo);
    /*
     *通过商品id删除供应商的基本信息
     */
    public boolean deleteCustomer(int cusId);
}
