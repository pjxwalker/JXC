package com.aaa.dao;

import com.aaa.entity.ProductInfo;
import com.aaa.entity.ProductType;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/28 15:55
 * @Description:商品信息持久层
 */
public interface ProductInfoMapper {

    /*
    *获取所有商品基本信息
     */
    public List<Map> getProductInfoList(Map map);

    /*
    *根据条件获取满足条件商品有多少条记录
     */
    public int getProductCount(Map map);

    /*
    *获取商品信息表中最大的id
     */
    public int getMaxProductId();

    /*
    *获取所有的商品类型
     */
    public List<ProductType> getProductType();

    /*
    *添加商品基本信息
     */
    public int addProductInfo(ProductInfo productInfo);

    /*
    *通过id获取商品详细信息
     */
    public Map getProductInfoById(@Param("productId") Integer productId);

    /*
    *通过商品id对商品基本信息进行修改
     */
    public int modifyProductInfo(ProductInfo productInfo);

    /*
    *通过商品id删除商品的基本信息
     */
    public int deleteProductInfo(@Param("productId") Integer productId);
}
