package com.aaa.service;

import com.aaa.entity.ProviderInfo;

import java.util.List;
import java.util.Map;

public interface ProviderInfoService {
    /*
     *获取所有供应商基本信息
     */
    public List<Map> getProviderInfoList(Map map);
    /*
     *根据条件获取满足条件供应商有多少条记录
     */
    public int getProviderCount(Map map);
    /*
     *添加供应商基本信息
     */
    public boolean addProviderInfo(ProviderInfo providerInfo);
    /*
     *通过id获取供应商详细信息
     */
    public ProviderInfo getProviderInfoById(int proId);
    /*
     *通过商品id对商品基本信息进行修改
     */
    public boolean modifyProviderInfo(ProviderInfo providerInfo);
    /*
     *通过商品id删除供应商的基本信息
     */
    public boolean deleteProciderInfo(int proId);
}
