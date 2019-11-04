package com.aaa.controller;

import com.aaa.service.SaleSetvice;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/sale")
public class SaleController {
    @Resource
    private SaleSetvice saleSetvice;
/*    @RequestMapping("/tocaigou")
    public String ToCaiGou(){
        return "/sale/caigou";
    }*/

//    获取仓库type
    @RequestMapping("/getrepositoryTypeId")
    @ResponseBody
    public List<Map> getRepositoryTypeId() {
        return saleSetvice.getRepositoryTypeId();
    }

    @RequestMapping("/getproduct")
    @ResponseBody
    public List<Map> productInfoList(){
        return saleSetvice.getProduct();
    }

    @RequestMapping("/getNo")
    @ResponseBody
    public String OrderNo(){
        String orderid=null;
        int count= saleSetvice.SaleOrderCount();
        System.out.println(count*10);
        int i=10;
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
            while (count >i) {
                i*=i;
            }
            while (count<=i){
                if(count<i){
                    count+=1;
                    orderid="SO"+sdf.format(new Date())+count;
                    break;
                }
                if(count==i){
                    i*=i;
                }
            }
            return  orderid;
        }

    @RequestMapping("/xiaoshou")
    public String ToXS(){
        return "/sale/salebill";
    }

    @RequestMapping("/xinxi")
    public String ToXinXi(){
        return "/sale/saleinformation";
    }

    @RequestMapping("/getSaleMaster")
    @ResponseBody
    public PageInfo getSaleMaster(String saler,String proposer,PageInfo pageInfo){
        return  saleSetvice.SelectSaleMaster(saler,proposer,pageInfo);
    }

    @RequestMapping("/getSaleDetailByNo")
    @ResponseBody
    public List<Map> getSaleDetailByNo(String saleNo){
        System.out.println(saleNo);
        return  saleSetvice.SelectSaleDetailByNo(saleNo);
    }

    @RequestMapping("/addso")
    @ResponseBody
    public String AddSaleOrder(@RequestBody Map map){
        System.out.println(map);
        boolean flag=saleSetvice.AddSaleOrder(map);
        if(flag==true){
            return "true";
        }
        return "false";
    }

    @RequestMapping("/DeleteSaleMaster")
    @ResponseBody
    public String DeleteSaleMaster(String saleNo){
        System.out.println("aa");
        int i=saleSetvice.DeleteSaleMaster(saleNo);
        if (i>0){
            return "true";
        }else {
            return "false";
        }
    }

    @RequestMapping("/DeleteSaleDetail")
    @ResponseBody
    public String DeleteSaleDetail(Integer detailId){
        int i=saleSetvice.DeleteSaleDetail(detailId);
        if (i>0){
            return "true";
        }else {
            return "false";
        }
    }

    @RequestMapping("/update")
    @ResponseBody
    public String UpdateOrder(@RequestBody Map map){
        System.out.println(map);
        boolean flag=saleSetvice.updateSaleOrder(map);
        if(flag==true){
            return "true";
        }
        return "false";
    }


    @RequestMapping("/yssp")
    public String toYSSP(){
        return "/sale/showsaleproduct";
    }

    @RequestMapping("/chuku")
    public String toChuKu(){
        return "/sale/saledeportout";
    }

    @RequestMapping("selectChuKu")
    @ResponseBody
    public List<Map> SelectChuKu(String cusName, String cusContactPhone, String saleNo, String repositoryTypeId){
        System.out.println(saleNo+"--"+ cusName+"--"+cusContactPhone+"--"+repositoryTypeId);
        return saleSetvice.SelectChuKu( cusName, cusContactPhone,saleNo,repositoryTypeId);

    }
    @RequestMapping("/selectSaleMasterFH")
    @ResponseBody
    public PageInfo SelectSaleMasterFH(String saler,String proposer,PageInfo pageInfo){
//        System.out.println(saleSetvice.SelectSaleMasterFH().toString());
        return saleSetvice.SelectSaleMasterFH( saler, proposer,pageInfo);

    }

    @RequestMapping("/updateRepository")
    @ResponseBody
    public String UpdateRepository(@RequestBody  Map map){
        System.out.println(map);
        boolean flag=saleSetvice.updateRepository(map);
        if(flag==true){
            return "true";
        }
        return "false";
    }

    @RequestMapping("/xiugaiExplain")
    @ResponseBody
    public String xiugaiExplain(String explains,String saleNo){
        System.out.println(saleNo+"--"+explains);
        int count=saleSetvice.updateSaleMasterEx(explains,saleNo);
        if(count>0){
            return "true";
        }
        return "false";
    }

    @RequestMapping("/getSaleProduct")
    @ResponseBody
    public PageInfo getSaleProduct(String productName,PageInfo pageInfo){
        return saleSetvice.getSaleProduct(productName,pageInfo);
    }
}
