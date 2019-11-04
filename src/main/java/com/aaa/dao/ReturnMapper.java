package com.aaa.dao;

import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ReturnMapper {
    /*
     *获取所有销售单基本信息
     */
    public List<Map> getSaleInfoList(Map maps);
    /*
     *根据条件获取满足条件的销售单有多少条记录
     */
    public int getSaleCount(Map maps);
    /*
     *获取所有销售单商品基本信息
     */
    public List<Map> getDetailSaleInfoList(Map maps);
    /*
     *根据条件获取满足条件销售单商品有多少条记录
     */
    public int getDetailSaleCount(Map maps);


    /*
     *根据编号删除符合条件的销售总单
     */
    public int returnSaleMaster(String saleNo);
    /*
     *根据编号删除符合条件的销售单
     */
    public int returnSaleDetail(String saleNo);
    /*
     *根据id删除符合条件的销售单
     */
    public int deleteSaleDetail(int detailId);


    /*
     *根据条件获取销售单的总价
     */
    public float selectotalprice(int detailId);
    /*
     *根据条件修改销售单商品基本信息
     */
    public int modifySaleInfo(Map map);
    /*
     *根据条件修改销售单总价
     */
    public int modifySaletotal(Map map);


    /*
     *获取仓库名
     */
    public List<Map> getRepositoryName();

    /*
    *检验该仓库是否有该商品
    */
    public int checkProduct(Map map);

    /*
     *查出该仓库的该商品库存
     */
    public int getreCount(Map map);

    /*
     *更新该仓库的该商品库存
     */
    public int modifyreCount(Map map);

    /*
     *增加该仓库的该商品库存
     */
    public int addRepository(Map map);

    /*
     *获取所有销售单基本信息
     */
    public List<Map> getSaleDetail(String saleNo);
}
