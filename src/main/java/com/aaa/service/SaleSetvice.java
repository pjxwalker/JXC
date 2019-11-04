package com.aaa.service;

import com.github.pagehelper.PageInfo;

import java.util.List;
import java.util.Map;

public interface SaleSetvice {
    public List<Map> getProduct();
    public int SaleOrderCount();

    //    获取仓库type
    public  List<Map> getRepositoryTypeId();

    //    查询已售商品
//    public List<Map> getSaleProduct();
    public PageInfo getSaleProduct(String productName, PageInfo pageInfo);
//    增加销售签单
    public boolean AddSaleOrder(Map map);

    //    查询销售签单
    public List<Map> SelectSaleDetail();
//    public List<Map> SelectSaleMaster();
    public PageInfo SelectSaleMaster(String saler, String proposer, PageInfo pageInfo);
    public List<Map> SelectSaleDetailByNo(String saleNo);
    public List<Map> SelectChuKu(String cusName, String cusContactPhone, String saleNo, String repositoryTypeId);
    public PageInfo SelectChuKu(String cusName, String cusContactPhone, String saleNo, String repositoryTypeId, PageInfo pageInfo);
//    public List<Map> SelectSaleMasterFH();
    public PageInfo SelectSaleMasterFH(String saler, String proposer, PageInfo pageInfo);

    //    删除销售签单


    public int DeleteSaleDetail(Integer detailId);
    public int DeleteSaleMaster(String saleNo);


    //    更改销售签单
//    public int updateSaleMaster(List list);
    public boolean updateSaleOrder(Map map);
    //    更改库存
    public boolean updateRepository(Map map);

    public int updateSaleMasterEx(String saleNo, String explains);
}
