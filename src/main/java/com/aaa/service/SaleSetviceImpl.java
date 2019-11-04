package com.aaa.service;

import com.aaa.dao.SaleMapper;
import com.aaa.entity.CustomerInfo;
import com.aaa.entity.ProductInfo;
import com.aaa.entity.SaleDetail;
import com.aaa.entity.SaleMaster;
import com.aaa.service.SaleSetvice;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

@Service
public class SaleSetviceImpl  implements SaleSetvice {
    @Resource
    private SaleMapper saleMapper;

    //    获取列表
    @Override
    public List<Map> getProduct() {
        return saleMapper.getProduct();
    }
//    增加销售签单
    @Override
    public boolean AddSaleOrder(Map map) {
        int master=saleMapper.AddSaleMaster(map);
        CustomerInfo customerInfo=new CustomerInfo();
        customerInfo=saleMapper.getCustomer(map);
        if (customerInfo==null){
            saleMapper.addCustomer(map);
        }
        List<Map> list= (List<Map>) map.get("saleorder");
        int detail=saleMapper.AddSaleDetail(list);
        if (master>0 && detail>0){
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public List<Map> SelectSaleDetail() {
        return saleMapper.SelectSaleDetail();
    }

  /*  @Override
    public List<Map> SelectSaleMaster() {
        return saleMapper.SelectSaleMaster();
    }*/

    @Override
    public PageInfo SelectSaleMaster(String saler,String proposer,PageInfo pageInfo) {
        PageHelper.startPage(pageInfo.getPageNum(),pageInfo.getPageSize());
        PageInfo page=new PageInfo(saleMapper.SelectSaleMaster(saler,proposer));
        return page;
    }

    @Override
    public List<Map> SelectSaleDetailByNo(String saleNo) {
        return saleMapper.SelectSaleDetailByNo(saleNo);
    }

    //    出库查询
    @Override
    public List<Map> SelectChuKu(String cusName,String cusContactPhone,String saleNo,String repositoryTypeId) {
        return saleMapper.SelectChuKu(cusName,cusContactPhone,saleNo,repositoryTypeId);
    }
//    出库查询
    @Override
    public PageInfo SelectChuKu(String cusName, String cusContactPhone, String saleNo, String repositoryTypeId, PageInfo pageInfo) {
        PageHelper.startPage(pageInfo.getPageNum(),pageInfo.getPageSize());
        PageInfo page=new PageInfo(saleMapper.SelectChuKu(cusName,cusContactPhone,saleNo,repositoryTypeId));
        return  page;
    }

   /* @Override
    public List<Map> SelectSaleMasterFH() {
        return saleMapper.SelectSaleMasterFH();
    }
*/
    @Override
    public PageInfo SelectSaleMasterFH(String saler,String proposer,PageInfo pageInfo) {
        PageHelper.startPage(pageInfo.getPageNum(),pageInfo.getPageSize());
        PageInfo page=new PageInfo(saleMapper.SelectSaleMasterFH( saler, proposer));
        return page;
    }

    @Override
    public int DeleteSaleDetail(Integer detailId) {
        SaleDetail saleDetail=saleMapper.SelectSaleDetailById(detailId);
        String saleNo=saleDetail.getSaleNo();
        int i=saleMapper.DeleteSaleDetail(detailId);
        if (saleMapper.SelectSaleDetailByNo(saleNo)==null){//如果根据签单号查不出明细表
            saleMapper.DeleteSaleMaster(saleNo);//直接删除总表
        }
        return i;
    }

    @Override
    public int DeleteSaleMaster(String saleNo) {
        int i=saleMapper.DeleteSaleMaster(saleNo);
        if (i>0){
           int j=saleMapper.DeleteSaleDetailByNo(saleNo);
        }
        return i;
    }

    @Override
    public boolean updateSaleOrder(Map map) {
        int master=saleMapper.updateSaleMaster(map);
        List<Map> list= (List<Map>) map.get("saleorder");
        int detail=saleMapper.updateSaleDetail(list);
        if (master>0 && detail>0){
            return true;
        }
        else {
            return false;
        }
    }
//    出库更改
    @Override
    public boolean updateRepository(Map map) {
//        List<Map> list= (List<Map>) map.get("productarr");
        System.out.println(map);
        int repoistory=saleMapper.updateRepository(map);
        if (repoistory>0 ){
            saleMapper.updateSaleMasterSta(map.get("saleNo").toString());
            return true;
        }
        else {
            return false;
        }
    }

    @Override
    public int updateSaleMasterEx( String explains,String saleNo) {
        return saleMapper.updateSaleMasterEx(explains,saleNo);
    }


/*    @Override
    public int updateSaleDetail(Map map) {
        return 0;
    }

    @Override
    public int updateSaleMaster(List list) {
        return 0;
    }*/

    //    查询销售签单数量获取No
    @Override
    public int SaleOrderCount() {
        return saleMapper.SaleOrderCount();
    }
    //    获取仓库type
    @Override
    public List<Map> getRepositoryTypeId() {
        return saleMapper.getRepositoryTypeId();
    }

    //    查询已售商品
    /*@Override
    public List<Map> getSaleProduct() {
        return saleMapper.getSaleProduct();
    }*/
    @Override
    public PageInfo getSaleProduct(String productName,PageInfo pageInfo) {
        PageHelper.startPage(pageInfo.getPageNum(),pageInfo.getPageSize());
        PageInfo page=new PageInfo(saleMapper.getSaleProduct(productName));
        return page;
    }
}
