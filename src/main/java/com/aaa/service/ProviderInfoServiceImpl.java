package com.aaa.service;

import com.aaa.dao.ProviderInfoMapper;
import com.aaa.entity.ProviderInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class ProviderInfoServiceImpl implements ProviderInfoService{
    @Resource
    public ProviderInfoMapper providerInfoMapper;

    @Override
    public List<Map> getProviderInfoList(Map map) {

        return providerInfoMapper.getProviderInfoList(map);
    }

    @Override
    public int getProviderCount(Map map) {
        return providerInfoMapper.getProviderCount(map);
    }

    @Override
    public boolean addProviderInfo(ProviderInfo providerInfo) {
        int num=providerInfoMapper.addProviderInfo(providerInfo);
        if(num>0)
        {
            return true;
        }
        return false;
    }

    @Override
    public ProviderInfo getProviderInfoById(int proId) {
        return providerInfoMapper.getProviderInfoById(proId);
    }

    @Override
    public boolean modifyProviderInfo(ProviderInfo providerInfo) {
        int num=providerInfoMapper.modifyProviderInfo(providerInfo);
        if(num>0)
        {
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteProciderInfo(int proId) {
        int num=providerInfoMapper.deleteProviderInfo(proId);
        if(num>0)
        {
            return true;
        }
        return false;
    }


}
