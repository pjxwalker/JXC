package com.aaa.service;

import com.aaa.dao.CustomerInfoMapper;
import com.aaa.entity.CustomerInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class CustomerInfoServiceImpl implements CustomerInfoService {
    @Resource
    public CustomerInfoMapper customerInfoMapper;
    @Override
    public List<Map> getCustomerInfoList(Map map) {
        return customerInfoMapper.getCustomerInfoList(map);
    }

    @Override
    public int getCustomerCount(Map map) {
        return customerInfoMapper.getCustomerCount(map);
    }

    @Override
    public boolean addCustomerInfo(CustomerInfo customerInfo) {
        int num=customerInfoMapper.addCustomer(customerInfo);
        if(num>0)
        {
            return true;
        }
        return false;
    }

    @Override
    public CustomerInfo getCustomerInfoById(int cusId) {
        return customerInfoMapper.getCustomerInfoById(cusId);
    }

    @Override
    public boolean modifycustomer(CustomerInfo customerInfo) {
        int num=customerInfoMapper.modifycustomer(customerInfo);
        if(num>0)
        {
            return true;
        }
        return false;
    }


    @Override
    public boolean deleteCustomer(int cusId) {
        int num=customerInfoMapper.deleteCustomer(cusId);
        if(num>0)
        {
            return true;
        }
        return false;
    }
}
