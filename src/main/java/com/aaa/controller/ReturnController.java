package com.aaa.controller;


import com.aaa.service.ReturnService;
import com.aaa.util.ResultMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/return")
public class ReturnController {

    @Resource
    public ReturnService returnService;

    @RequestMapping("/getSaleInfoList")
    @ResponseBody
    public Object getSaleInfoList(@RequestParam(value="page",required = false)Integer page,
                                  @RequestParam(value="limit",required = false)Integer limit,
                                  @RequestParam(value="saleNo",required = false)String saleNo,
                                  @RequestParam(value="saler",required = false)String saler)
    {
        Map<String,Object> map=new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("saleNo",saleNo);
        map.put("saler",saler);
        List<Map> mapList=returnService.getSaleInfoList(map);
        int count=returnService.getSaleCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    @RequestMapping("/showSaleInfo/{saleNo}/{saler}/{reName}/{reId}")
    public String showSaleInfo(Model model, @PathVariable("saleNo") String saleNo, @PathVariable("saler") String saler,@PathVariable("reName") String reName,@PathVariable("reId") int reId)
    {
        //System.out.println(reName+"/"+reId);
        Map<String,Object>map=new HashMap<>();
        map.put("saleNo",saleNo);
        map.put("saler",saler);
        map.put("reName",reName);
        map.put("reId",reId);
        //System.out.println(map);
        model.addAttribute("sale",map);
        return "return/showsale";
    }

    @RequestMapping("/getDetailSaleInfoList")
    @ResponseBody
    public Object getDetailSaleInfoList(@RequestParam(value="page",required = false)Integer page,
                                        @RequestParam(value="limit",required = false)Integer limit,
                                        @RequestParam(value="saleNo",required = false)String saleNo,
                                        @RequestParam(value="productName",required = false)String productName,
                                        @RequestParam(value="typeName",required = false)String typeName)
    {
        Map<String,Object> map=new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("saleNo",saleNo);
        map.put("productName",productName);
        map.put("typeName",typeName);
        List<Map> mapList=returnService.getDetailSaleInfoList(map);
        int count=returnService.getDetailSaleCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    @RequestMapping("/deleteSaleMaster")
    @ResponseBody
    public Object deleteSaleMaster(String saleNo,int reId)
    {
        boolean flag=returnService.returnsalemaster(saleNo,reId);
        if (flag)
        {
            return true;
        }
        return false;
    }

    @RequestMapping("/returnSale")
    @ResponseBody
    public Object returnSale(int detailId,int returnNumber,int productNumber,float productOutPrice,float subtotal,String productNo,int reId)
    {
        //System.out.println(productNo+"/"+reId);
        int newNumber=productNumber-returnNumber;
        float newtotal=productOutPrice*newNumber;
        boolean flag=returnService.returnSale(detailId,newNumber,newtotal,subtotal,productNo,reId,returnNumber);
        if (flag){
            return "true";
        }
        return "false";
    }

    @RequestMapping("/deleteSaleProduct")
    @ResponseBody
    public Object deleteSaleProduct(int detailId,float subtotal,String productNo,int reId,int productNumber)
    {
        //System.out.println(productNo);
        boolean flag=returnService.deleteSaleProduct(detailId,subtotal,reId,productNumber,productNo);
        if (flag){
            return "true";
        }
        return "false";
    }

    @RequestMapping("/getRepositoryName")
    @ResponseBody
    public List<Map> getRepositoryName()
    {
        return returnService.getRepositoryName();
    }
}
