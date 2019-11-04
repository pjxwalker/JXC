package com.aaa.service;

import com.aaa.dao.ProductInfoMapper;
import com.aaa.entity.ProductInfo;
import com.aaa.entity.ProductType;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/28 20:54
 * @Description:实现ProductInfoService接口
 */
@Service
public class ProductInfoServiceImpl implements ProductInfoService {

    @Resource
    private ProductInfoMapper productInfoMapper;

    @Override
    public List<Map> getProductInfoList(Map map) {
        return productInfoMapper.getProductInfoList(map);
    }

    @Override
    public int getProductCount(Map map) {
        return productInfoMapper.getProductCount(map);
    }

    @Override
    public int getMaxProductId() {
        return productInfoMapper.getMaxProductId();
    }

    @Override
    public List<ProductType> getProductType() {
        return productInfoMapper.getProductType();
    }

    @Override
    public boolean addProductInfo(ProductInfo productInfo) {
        int num=productInfoMapper.addProductInfo(productInfo);
        if (num>0){
            return true;
        }
        return false;
    }

    @Override
    public Map getProductInfoById(Integer productId) {
        return productInfoMapper.getProductInfoById(productId);
    }

    @Override
    public boolean modifyProductInfo(ProductInfo productInfo) {
        int num=productInfoMapper.modifyProductInfo(productInfo);
        if (num>0){
            return true;
        }
        return false;
    }

    @Override
    public boolean deleteProductInfo(Integer productId) {
        int num=productInfoMapper.deleteProductInfo(productId);
        if (num>0){
            return true;
        }
        return false;
    }
}
