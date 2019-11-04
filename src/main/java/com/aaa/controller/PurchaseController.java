package com.aaa.controller;

import com.aaa.entity.EmployeeInfo;
import com.aaa.service.PurchaseService;
import com.aaa.util.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/30 11:41
 * @Description:
 */
@Controller
@RequestMapping("/purchase")
public class PurchaseController {

    @Autowired
    private PurchaseService purchaseService;

    @RequestMapping("/getProductList")
    @ResponseBody
    public Object getProductList(@RequestParam(value="typeNo",required = false)String typeNo,
                                 @RequestParam(value="productNo",required = false)String productNo){
        //System.out.println("---------typeNo:"+typeNo+"-------productNo:"+productNo);
        return  purchaseService.getProductList(typeNo,productNo);
    }

    @RequestMapping("/addPurchase")
    @ResponseBody
    public Object addPurchase(@RequestBody Map map){
        //System.out.println(map.toString());
        boolean flag=purchaseService.addPurchase(map);
        if (flag){
            return "true";
        }
        return "false";
    }

    @RequestMapping("/getPurchaseNo")
    @ResponseBody
    public Object getPurchaseNo(){
        String purchaseNo=null;
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
        int count=purchaseService.getPurchaseMaxId();
        if(count==0){
            purchaseNo="NO"+sdf.format(new Date())+"001";
        }else
        if(count<10){
            purchaseNo="NO"+sdf.format(new Date())+"00"+count;
        }else if(count<100){
            purchaseNo="NO"+sdf.format(new Date())+"0"+count;
        }else{
            purchaseNo="NO"+sdf.format(new Date())+count;
        }
        return purchaseNo;
    }

    //管理员或仓库管理员查看
    @RequestMapping("/getPurchaseList")
    @ResponseBody
    public Object getPurchaseList(HttpSession session,
                                  @RequestParam(value="page",required = false)Integer page,
                                  @RequestParam(value="limit",required = false)Integer limit,
                                  @RequestParam(value="purchaseNo",required = false)String purchaseNo,
                                  @RequestParam(value="proposer",required = false)String proposer,
                                  @RequestParam(value="applyBranch",required = false)String applyBranch){
        Map<String,Object> map=new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("purchaseNo",purchaseNo);
        map.put("proposer",proposer);
        map.put("applyBranch",applyBranch);
        List<Map> mapList=purchaseService.getPurchaseList(map);
        int count =purchaseService.getPurchaseCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    //采购人员查看采购订单
    @RequestMapping("/purchaseView")
    @ResponseBody
    public Object purchaseView(HttpSession session,
                               @RequestParam(value="page",required = false)Integer page,
                               @RequestParam(value="limit",required = false)Integer limit,
                               @RequestParam(value="purchaseNo",required = false)String purchaseNo,
                               @RequestParam(value="proposer",required = false)String proposer,
                               @RequestParam(value="applyBranch",required = false)String applyBranch){
        Map<String,Object> map=new HashMap<>();
        EmployeeInfo employeeInfo=(EmployeeInfo)session.getAttribute("emp");
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("purchaseNo",purchaseNo);
        map.put("proposer",proposer);
        map.put("applyBranch",applyBranch);
        map.put("roleId",employeeInfo.getRoleId());
        map.put("empName",employeeInfo.getEmpName());
        List<Map> mapList=purchaseService.getPurchaseList(map);
        int count =purchaseService.getPurchaseCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    //异步获取所有的订单状态
    @RequestMapping("/getOrderStatus")
    @ResponseBody
    public Object getOrderStatus(){
        List<Map> mapList=purchaseService.getOrderStatus();
        return mapList;
    }

    //加载采购订单详细页面
    @RequestMapping(value="/getPurchase/{purchaseId}")
    public String getPurchase(@PathVariable Integer purchaseId, Model model){
        Map map=purchaseService.getPurchase(purchaseId);
        List<Map> mapList=(List<Map>)map.get("mapList");
        model.addAttribute("purchase",map);
        return "purchase/checkPurchase";
    }

    //异步请求更改订单状态
    @RequestMapping("/updateStatus")
    @ResponseBody
    public String updateOrderStatus(Integer statusId,Integer purchaseId){
        boolean flag=purchaseService.updateStatus(statusId,purchaseId);
        if (flag){
            return "true";
        }
        return "false";
    }



    //采购订单查询
    @RequestMapping("purchaseList")
    @ResponseBody
    public Object purchaseList(@RequestParam(value="page",required = false)Integer page,
                                    @RequestParam(value="limit",required = false)Integer limit,
                                    @RequestParam(value="purchaseNo",required=false)String purchaseNo,
                                    @RequestParam(value="purchaser",required=false)String purchaser) {
        List<Map> purchaseMasters = purchaseService.findPurchaseList((page - 1) * limit, limit, purchaseNo, purchaser);
        int count =purchaseService.getPurchaseCount(purchaseNo, purchaser);
        return new ResultMap<List<Map>>("",purchaseMasters, 0, count);
    }

    @RequestMapping("getPurchaseByNo")
    public String getPurchaseByNo(HttpSession session,String purchaseNo){
        session.setAttribute("purchaseNo",purchaseNo);
        return "purchase/purchaseDetail";
    }

    @RequestMapping("purchaseDetail")
    @ResponseBody
    public Object purchaseDetail(@RequestParam(value="page",required = false)Integer page,
                                 @RequestParam(value="limit",required = false)Integer limit,
                                 HttpSession session){
        String purchaseNo=(String)session.getAttribute("purchaseNo");
        List<Map> purchaseDetail = purchaseService.findPurchaseDetailList((page - 1) * limit, limit, purchaseNo);
        int count =purchaseService.getPurchaseDetailCount(purchaseNo);
        return new ResultMap<List<Map>>("",purchaseDetail, 0, count);
    }


    @RequestMapping("/getPurchaseInfoList")
    @ResponseBody
    public Object getPurchaseInfoList(@RequestParam(value="page",required = false)Integer page,
                                      @RequestParam(value="limit",required = false)Integer limit,
                                      @RequestParam(value="purchaseNo",required = false)String purchaseNo,
                                      @RequestParam(value="purchaser",required = false)String purchaser)
    {
        Map<String,Object> map=new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("purchaseNo",purchaseNo);
        map.put("purchaser",purchaser);
        List<Map> mapList=purchaseService.getPurchaseInfoList(map);
        int count=purchaseService.getPurchaseCounts(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    @RequestMapping("/showPurchaseInfo/{purchaseNo}/{purchaser}")
    public String showPurchaseInfo(Model model, @PathVariable("purchaseNo") String purchaseNo,@PathVariable("purchaser") String purchaser)
    {
        Map<String,Object>map=new HashMap<>();
        map.put("purchaseNo",purchaseNo);
        map.put("purchaser",purchaser);
        System.out.println(map);
        model.addAttribute("purchase",map);
        return "return/showpurchase";
    }

    @RequestMapping("/getDetailPurchaseInfoList")
    @ResponseBody
    public Object getDetailPurchaseInfoList(@RequestParam(value="page",required = false)Integer page,
                                            @RequestParam(value="limit",required = false)Integer limit,
                                            @RequestParam(value="purchaseNo",required = false)String purchaseNo,
                                            @RequestParam(value="productName",required = false)String productName,
                                            @RequestParam(value="typeName",required = false)String typeName)
    {
        Map<String,Object> map=new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("purchaseNo",purchaseNo);
        map.put("productName",productName);
        map.put("typeName",typeName);
        List<Map> mapList=purchaseService.getDetailPurchaseInfoList(map);
        int count=purchaseService.getDetailPurchaseCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    @RequestMapping("/returnPurchase")
    @ResponseBody
    public Object returnPurchase(int detailId,int returnNumber,int productNumber,float productInPrice,float subtotal)
    {
        int newNumber=productNumber-returnNumber;
        float newtotal=productInPrice*newNumber;
        boolean flag=purchaseService.returnPurchase(detailId,newNumber,newtotal,subtotal);
        if (flag){
            return "true";
        }
        return "false";
    }

    @RequestMapping("/deletePurchaseProduct")
    @ResponseBody
    public Object deletePurchaseProduct(int detailId,float subtotal)
    {
        boolean flag=purchaseService.deletePurchaseProduct(detailId,subtotal);
        if (flag){
            return "true";
        }
        return "false";
    }
}
