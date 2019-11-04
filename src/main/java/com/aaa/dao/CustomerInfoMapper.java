package com.aaa.dao;

import com.aaa.entity.CustomerInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface CustomerInfoMapper {
    public List<Map> getCustomerInfoList(Map map);
    public int getCustomerCount(Map map);
    public int addCustomer(CustomerInfo customerInfo);
    public CustomerInfo getCustomerInfoById(int cusid);
    public int deleteCustomer(int cusId);
    public int modifycustomer(CustomerInfo customerInfo);
}
