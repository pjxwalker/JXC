package com.aaa.service;

import com.aaa.dao.DepotInMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class DepotInServiceImpl implements DepotInService {

    @Resource
    DepotInMapper depotInMapper;


    @Override
    public List<Map> findDepotInList(Integer start,Integer limit,String depotInNo,String empName,String productName) {
        return depotInMapper.findDepotInList(start,limit,depotInNo,empName,productName);
    }

    @Override
    public List<String> getAllProductName() {
        return depotInMapper.getAllProductName();
    }

    @Override
    public int findDepotInCount(String depotInNo, String empName, String productName) {
        return depotInMapper.findDepotInCount(depotInNo,empName, productName);
    }

    @Override
    public Map getDetailByNo(String depotInNo) {
        return depotInMapper.getDetailByNo(depotInNo);
    }
}
