package com.aaa.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/30 12:24
 * @Description:
 */
public interface PurchaseMapper {

    /*
     *通过商品编号或商品类型获取商品信息
     */
    public List<Map> getProductList(@Param("typeNo")String typeNo,@Param("productNo") String productNo);

    /*
     *添加采购订单总表
     */
    public int addPurchase(Map map);

    /*
     *添加采购订单详细表中数据
     */
    public int addPurchaseDetail(List<Map> list);

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
    public Map getPurchase(@Param("purchaseId")Integer purchaseId);

    /*
     *通过订单id更改状态
     */
    public int updateStatus(@Param("statusId")Integer statusId,@Param("purchaseId")Integer purchaseId);





    /**
     * 分页查询采购订单记录
     */
    List<Map> findPurchaseList(@Param("start") Integer start,
                              @Param("limit")Integer limit,
                              @Param("purchaseNo")String purchaseNo,
                              @Param("purchaser")String purchaser
    );

    //采购订单行数
    int findPurchaseCount(@Param("purchaseNo")String purchaseNo,@Param("purchaser")String purchaser );

    //采购订单详情表
    List<Map> findPurchaseDetailList(@Param("page") Integer page,
                                     @Param("limit")Integer limit,
                                     @Param("purchaseNo")String purchaseNo);

    //采购订单详情表行数
    int getPurchaseDetailCount(@Param("purchaseNo")String purchaseNo);






    //pjx
    /*
     *获取所有已购入采购单基本信息
     */
    public List<Map> getPurchaseInfoList(Map maps);
    /*
     *根据条件获取满足条件已售采购单有多少条记录
     */
    public int getPurchaseCounts(Map maps);
    /*
     *获取所有已购入采购单商品基本信息
     */
    public List<Map> getDetailPurchaseInfoList(Map maps);
    /*
     *根据条件获取满足条件已售采购单商品有多少条记录
     */
    public int getDetailPurchaseCount(Map maps);
    /*
     *根据条件获取采购单的总价
     */
    public float selectotalprice(int detailId);
    /*
     *根据条件修改已购入采购单商品基本信息
     */
    public int returnPurchase(Map map);
    /*
     *根据条件修改已购入采购单总价
     */
    public int modifyPurchaseMaster(Map map);
    /*
     *根据条件删除采购单商品
     */
    public int deletePurchaseProduct(int detailId);
}
