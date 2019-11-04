package com.aaa.dao;

import com.aaa.entity.CustomerInfo;
import com.aaa.entity.SaleDetail;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface SaleMapper {
//    获取列表
    public List<Map> getProduct();
    public int AddPurchase_master(Map map);
//    获取仓库type
    public  List<Map> getRepositoryTypeId();
//    查询买家是否存在
    public CustomerInfo getCustomer(Map map);
    public int addCustomer(Map map);
    //    查询销售签单数量获取No
    public int SaleOrderCount();

//    查询已售商品
    public List<Map> getSaleProduct(@Param("productName") String productName);
//    增加销售签单
    public int AddSaleMaster(Map map);
    public int AddSaleDetail(List list);

//    查询销售签单
    public SaleDetail SelectSaleDetailById(Integer detailId);
    public List<Map> SelectSaleDetail();
    public List<Map> SelectSaleDetailByNo(String saleNo);
    public List<Map> SelectSaleMaster(@Param("saler") String saler, @Param("proposer") String proposer);
    public List<Map> SelectSaleMasterFH(@Param("saler") String saler, @Param("proposer") String proposer);
    public List<Map> SelectSaleMasterByNo(String saleNo);
    public List<Map> SelectChuKu(@Param("cusName") String cusName,
                                 @Param("cusContactPhone") String cusContactPhone,
                                 @Param("saleNo") String saleNo,
                                 @Param("repositoryTypeId") String repositoryTypeId);

//    删除销售签单
    public int DeleteSaleDetail(Integer detailId);
    public int DeleteSaleDetailByNo(String saleNo);
    public int DeleteSaleMaster(String saleNo);

//    更改销售签单
    public int updateSaleDetail(List list);
    public int updateSaleMaster(Map map);
    public int updateSaleMasterEx(@Param("explains") String explains, @Param("saleNo") String saleNo);

    //出库更改
    public int updateSaleMasterSta(String saleNo);
    public int updateRepository(Map map);//@Param("repositoryTypeId")String repositoryTypeId)

}
