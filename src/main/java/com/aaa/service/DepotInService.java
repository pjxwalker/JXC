package com.aaa.service;

import java.util.List;
import java.util.Map;

public interface DepotInService {

    //入库查询
    List<Map> findDepotInList(Integer start,Integer limit,String depotInNo,String empName,String productName);

    //获取商品名称下拉列表
    List<String> getAllProductName();


     //获取入库记录行数
    public int findDepotInCount(String depotInNo,String empName,String productName);

    //入库记录详情
    public Map getDetailByNo(String depotInNo);

}