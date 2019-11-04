package com.aaa.dao;

import com.aaa.entity.ProviderInfo;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ProviderInfoMapper {
    public List<Map> getProviderInfoList(Map map);
    public int getProviderCount(Map map);
    public int addProviderInfo(ProviderInfo providerInfo);
    public ProviderInfo getProviderInfoById(int proId);
    public int modifyProviderInfo(ProviderInfo providerInfo);
    public int deleteProviderInfo(int proId);
}
