package com.aaa.controller;

import com.aaa.entity.ProductInfo;
import com.aaa.entity.ProductType;
import com.aaa.service.ProductInfoService;
import com.aaa.util.ResultMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: Peng
 * @Date: 2019/7/29 17:01
 * @Description:商品信息控制层
 */
@Controller
@RequestMapping("/product")
public class ProductInfoController {

    @Autowired
    private ProductInfoService productInfoService;

    //异步获取商品信息
    @RequestMapping("getProductInfoList")
    @ResponseBody
    public Object getProductInfoList(@RequestParam(value="page",required = false)Integer page,
                                     @RequestParam(value="limit",required = false)Integer limit,
                                     @RequestParam(value="productNo",required = false)String productNo,
                                     @RequestParam(value="productName",required = false)String productName,
                                     @RequestParam(value="typeNo",required = false)String typeNo){
        System.out.println("page-"+page+"limit-"+limit+"productNo-"+productNo+"productName-"+productName+"typeNo-"+typeNo+"---------------");
        Map<String,Object> map=new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("productNo",productNo);
        map.put("productName",productName);
        map.put("typeNo",typeNo);
        List<Map> mapList=productInfoService.getProductInfoList(map);
        int count=productInfoService.getProductCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);
    }

    //异步获取商品类型
    @RequestMapping("/getTypeList")
    @ResponseBody
    public Object getProductTypeList(){
        List<ProductType> productTypes=productInfoService.getProductType();
        return productTypes;
    }

    //加载添加商品页面
    @RequestMapping("/toAddProduct")
    public String toAddProductInfo(){

        return "product/addproduct";
    }

    @RequestMapping("/getProductNo")
    @ResponseBody
    public Object getProductNo(){
        String productNo=null;
        SimpleDateFormat sdf=new SimpleDateFormat("yyyyMMdd");
        int count=productInfoService.getMaxProductId();
        if(count==0){
            productNo="SP"+sdf.format(new Date())+"001";
        }else
        if(count<10){
            productNo="SP"+sdf.format(new Date())+"00"+count;
        }else if(count<100){
            productNo="SP"+sdf.format(new Date())+"0"+count;
        }else{
            productNo="SP"+sdf.format(new Date())+count;
        }
        return productNo;
    }

    //保存添加商品的基本信息
    @RequestMapping("/addproduct")
    @ResponseBody
    public Object saveAddProductInfo(ProductInfo productInfo){
        boolean flag=productInfoService.addProductInfo(productInfo);
        if (flag){
            return "true";
        }
        return "false";
    }

    //加载商品信息修改页面
    @RequestMapping(value="/toModifyProduct/{productId}")
    public String toModifyProduct(Model model, @PathVariable Integer productId){
        Map map=productInfoService.getProductInfoById(productId);
        model.addAttribute("product",map);
        return "product/modifyproduct";
    }

    //异步请求更改商品基本信息
    @RequestMapping("/modifyProduct")
    @ResponseBody
    public Object modifyProduct(ProductInfo productInfo){
        boolean flag=productInfoService.modifyProductInfo(productInfo);
        if (flag){
            return "true";
        }
        return "false";
    }

    //异步删除商品基本信息
    @RequestMapping("/deleteProduct")
    @ResponseBody
    public Object deleteProductInfo(Integer productId){
        boolean flag=productInfoService.deleteProductInfo(productId);
        if (flag){
            return "true";
        }
        return "false";
    }

    //加载商品详细信息页面
    @RequestMapping(value = "/showProductInfo/{productId}")
    public String showProductInfo(Model model,@PathVariable Integer productId){
        Map map=productInfoService.getProductInfoById(productId);
        model.addAttribute("product",map);
        return "product/showproduct";
    }
}
