package com.aaa.service;

import java.util.List;
import java.util.Map;

public interface ReturnService {
    /*
     *获取所有已购入采购单基本信息
     */
    public List<Map> getSaleInfoList(Map maps);
    /*
     *根据条件获取满足条件采购单有多少条记录
     */
    public int getSaleCount(Map maps);
    /*
     *获取所有已购入采购单商品基本信息
     */
    public List<Map> getDetailSaleInfoList(Map maps);
    /*
     *根据条件获取满足条件采购单商品有多少条记录
     */
    public int getDetailSaleCount(Map maps);
    /*
     *根据条件删除符合条件的销售总单和其销售单
     */
    public boolean returnsalemaster(String saleNo, int reId);

    /*
     *对销售总单的部分商品进行退货
     */
    public boolean returnSale(int detailId, int newNumber, float newtotal, float subtotal, String product, int reId, int returnNumber);


    /*
     *对销售总单的一个商品进行删除并更新总价
     */
    public boolean deleteSaleProduct(int detailId, float subtotal, int reId, int productNumber, String productNo);

    /*
     *获取仓库名
     */
    public List<Map> getRepositoryName();
}
