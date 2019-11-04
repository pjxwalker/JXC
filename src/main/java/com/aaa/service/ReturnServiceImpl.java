package com.aaa.service;

import com.aaa.dao.ReturnMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ReturnServiceImpl implements ReturnService {
    @Resource
    public ReturnMapper returnMapper;

    @Override
    public List<Map> getSaleInfoList(Map maps) {
        return returnMapper.getSaleInfoList(maps);
    }

    @Override
    public int getSaleCount(Map maps) {
        return returnMapper.getSaleCount(maps);
    }

    @Override
    public List<Map> getDetailSaleInfoList(Map maps) {
        return returnMapper.getDetailSaleInfoList(maps);
    }

    @Override
    public int getDetailSaleCount(Map maps) {
        return returnMapper.getDetailSaleCount(maps);
    }

    @Override
    public boolean returnsalemaster(String saleNo,int reId) {
        List<Map> mapList=returnMapper.getSaleDetail(saleNo);
        int num3=0;
        if(mapList.size()==0)
        {
            num3=1;
        }
        for (int i=0;i<mapList.size();i++)
        {
            num3=0;
            mapList.get(i).put("reId",reId);
            int num=returnMapper.checkProduct(mapList.get(i));
            if(num>0)
            {
                int productNumber=returnMapper.getreCount(mapList.get(i));
                System.out.println(productNumber);
                productNumber+=(int)mapList.get(i).get("productNumber");
                mapList.get(i).put("productNumber",productNumber);
                num3=returnMapper.modifyreCount(mapList.get(i));
            }
            else
            {
                num3=returnMapper.addRepository(mapList.get(i));
            }
        }
        int num1=returnMapper.returnSaleMaster(saleNo);
        int num2=returnMapper.returnSaleDetail(saleNo);
        System.out.println(num1+"//"+num2+"//"+saleNo);
        if(num1>0&&num3>0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    @Override
    public boolean returnSale(int detailId, int newNumber, float newtotal, float subtotal,String productNo,int reId,int returnNumber) {
       //更新库存
        int num3=0;
        Map<String,Object>map=new HashMap<>();
        map.put("reId",reId);
        map.put("productNo",productNo);
        map.put("retrunNumber",returnNumber);
        int num=returnMapper.checkProduct(map);
        if(num>0)
        {
            int productNumber=returnMapper.getreCount(map);
            productNumber+=returnNumber;
            map.put("productNumber",productNumber);
            num3=returnMapper.modifyreCount(map);
        }
        else
        {
            num3=returnMapper.addRepository(map);
        }

        //更新销售总单与销售单
        float totalprice=returnMapper.selectotalprice(detailId);
        Map<String,Object> maps=new HashMap<>();
        maps.put("detailId",detailId);
        maps.put("newNumber",newNumber);
        maps.put("newtotal",newtotal);
        float newPrice=totalprice-subtotal+newtotal;
        Map<String,Object> map1=new HashMap<>();
        map1.put("detailId",detailId);
        map1.put("newPrice",newPrice);
        int num1=returnMapper.modifySaleInfo(maps);
        int num2=returnMapper.modifySaletotal(map1);
        if(num1>0&&num2>0&&num3>0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    @Override
    public boolean deleteSaleProduct(int detailId, float subtotal,int reId,int productNumber,String productNo) {
        int num3=0;
        Map<String,Object>map=new HashMap<>();
        map.put("reId",reId);
        map.put("productNo",productNo);
        int num=returnMapper.checkProduct(map);
        if (num>0)
        {
            int newNum=returnMapper.getreCount(map);
            newNum+=productNumber;
            map.put("productNumber",newNum);
            num3=returnMapper.modifyreCount(map);
        }
        else
        {
            num3=returnMapper.addRepository(map);
        }

        float totalprice=returnMapper.selectotalprice(detailId);
        float newPrice=totalprice-subtotal;
        Map<String,Object> map1=new HashMap<>();
        map1.put("detailId",detailId);
        map1.put("newPrice",newPrice);

        int num1=returnMapper.modifySaletotal(map1);
        int num2=returnMapper.deleteSaleDetail(detailId);
        if(num1>0&&num2>0&&num3>0)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    @Override
    public List<Map> getRepositoryName() {
        return returnMapper.getRepositoryName();
    }
}
