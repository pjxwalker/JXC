package com.aaa.service;

import com.aaa.dao.PurchaseMapper;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/30 12:27
 * @Description:
 */
@Service
@Transactional
public class PurchaseServiceImpl implements PurchaseService {

    @Resource
    private PurchaseMapper purchaseMapper;
    @Override
    public List<Map> getProductList(String typeNo, String productNo) {
        return purchaseMapper.getProductList(typeNo,productNo);
    }

    @Override
    public boolean addPurchase(Map map) {
        int num=purchaseMapper.addPurchase(map);
        List<Map> mapList=(List<Map>)map.get("goods");
        int num2=purchaseMapper.addPurchaseDetail(mapList);
        if (num>0 && num2>0){
            return true;
        }
        return false;
    }

    @Override
    public int getPurchaseMaxId() {
        return purchaseMapper.getPurchaseMaxId();
    }

    @Override
    public List<Map> getPurchaseList(Map map) {
        return purchaseMapper.getPurchaseList(map);
    }

    @Override
    public int getPurchaseCount(Map map) {
        return purchaseMapper.getPurchaseCount(map);
    }

    @Override
    public List<Map> getOrderStatus() {
        return purchaseMapper.getOrderStatus();
    }

    @Override
    public Map getPurchase(Integer purchaseId) {
        return purchaseMapper.getPurchase(purchaseId);
    }

    @Override
    public boolean updateStatus(Integer statusId, Integer purchaseId) {
        int num=purchaseMapper.updateStatus(statusId, purchaseId);
        if (num>0){
            return true;
        }
        return false;
    }
    @Override
    public List<Map> findPurchaseList(Integer start,Integer limit,String purchaseNo,String purchaser) {
        return purchaseMapper.findPurchaseList(start,limit,purchaseNo,purchaser);
    }

    @Override
    public int getPurchaseCount(String purchaseNo, String purchaser) {
        return purchaseMapper.findPurchaseCount(purchaseNo,purchaser );
    }

    @Override
    public List<Map> findPurchaseDetailList(Integer page, Integer limit, String purchaseNo) {
        return purchaseMapper.findPurchaseDetailList(page,limit,purchaseNo);
    }

    @Override
    public int getPurchaseDetailCount(String purchaseNo) {
        return purchaseMapper.getPurchaseDetailCount(purchaseNo);
    }





    //pjx
    @Override
    public List<Map> getPurchaseInfoList(Map maps) {
        return purchaseMapper.getPurchaseInfoList(maps);
    }

    @Override
    public int getPurchaseCounts(Map maps) {
        return purchaseMapper.getPurchaseCounts(maps);
    }

    @Override
    public List<Map> getDetailPurchaseInfoList(Map maps) {
        return purchaseMapper.getDetailPurchaseInfoList(maps);
    }

    @Override
    public int getDetailPurchaseCount(Map maps) {
        return purchaseMapper.getDetailPurchaseCount(maps);
    }

    @Override
    public boolean returnPurchase(int detailId,int newNumber,float newtotal,float subtotal) {
        float totalPrice=purchaseMapper.selectotalprice(detailId);
        Map<String,Object> maps=new HashMap<>();
        maps.put("detailId",detailId);
        maps.put("newNumber",newNumber);
        maps.put("newtotal",newtotal);
        float newPrice=totalPrice-subtotal+newtotal;
        Map<String,Object> map1=new HashMap<>();
        map1.put("detailId",detailId);
        map1.put("newPrice",newPrice);
        int num1=purchaseMapper.returnPurchase(maps);
        int num2=purchaseMapper.modifyPurchaseMaster(map1);
        if(num1>0&&num2>0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    @Override
    public boolean deletePurchaseProduct(int detailId, float subtotal) {
        float totalPrice=purchaseMapper.selectotalprice(detailId);
        float newPrice=totalPrice-subtotal;
        Map<String,Object> map1=new HashMap<>();
        map1.put("detailId",detailId);
        map1.put("newPrice",newPrice);
        int num1=purchaseMapper.modifyPurchaseMaster(map1);
        int num2=purchaseMapper.deletePurchaseProduct(detailId);
        if(num1>0&&num2>0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }
}
