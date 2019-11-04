package com.aaa.service;

import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/30 12:27
 * @Description:
 */
public interface PurchaseService {

    /*
     *通过商品编号或商品类型获取商品信息
     */
    public List<Map> getProductList(String typeNo,String productNo);

    /*
     *添加采购订单总表和采购订单详细表
     */
    public boolean  addPurchase(Map map);

    /*
     *获取purchase_master 中最大的id
     */
    public int getPurchaseMaxId();

    /*
     *根据条件查询满足条件的所有采购订单
     */
    public List<Map> getPurchaseList(Map map);

    /*
     *根据条件查询出满足条件采购条数
     */
    public int getPurchaseCount(Map map);

    /*
     *查询出所有订单的状态
     */
    public List<Map> getOrderStatus();

    /*
     *通过一对多查询出采购订单的详细信息
     */
    public Map getPurchase(Integer purchaseId);

    /*
     *通过订单id更改状态
     */
    public boolean updateStatus(Integer statusId,Integer purchaseId);




    //采购订单查询
    public List<Map> findPurchaseList(Integer start,Integer limit,String purchaseNo,String purchaser);

    //采购订单数目
    public int getPurchaseCount(String purchaseNo,String purchaser);

    //采购订单详情表
    public List<Map> findPurchaseDetailList(Integer page,Integer limit,String purchaseNo);

    //采购订单详情表行数
    public int getPurchaseDetailCount(String purchaseNo);





//pjx
    /*
     *获取所有已购入采购单基本信息
     */
    public List<Map> getPurchaseInfoList(Map maps);
    /*
     *根据条件获取满足条件采购单有多少条记录
     */
    public int getPurchaseCounts(Map maps);
    /*
     *获取所有已购入采购单商品基本信息
     */
    public List<Map> getDetailPurchaseInfoList(Map maps);
    /*
     *根据条件获取满足条件采购单商品有多少条记录
     */
    public int getDetailPurchaseCount(Map maps);
    /*
     *对采购单进行退货
     */
    public boolean returnPurchase(int detailId,int newNumber,float newtotal,float subtotal);
    /*
     *对采购单的一个商品进行删除并更新总价
     */
    public boolean deletePurchaseProduct(int detailId, float subtotal);
}
