package com.aaa.controller;

import com.aaa.service.DepotInService;
import com.aaa.util.ResultMap;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("depotIn")
public class DepotInController {

    @Resource
    DepotInService depotInService;


    /**
     * 入库查询
     * @param page
     * @param limit
     * @param depotInNo
     * @param empName
     * @param productName
     * @return
     */
    @RequestMapping("depotInList")
    @ResponseBody
    public Object DepotInMasterList(@RequestParam(value="page",required = false)Integer page,
                                    @RequestParam(value="limit",required = false)Integer limit,
                                    @RequestParam(value="depotInNo",required=false)String depotInNo,
                                    @RequestParam(value="empName",required=false)String empName,
                                    @RequestParam(value="productName",required=false)String productName ){
        List<Map> depotInMasters=depotInService.findDepotInList((page-1)*limit,limit,depotInNo,empName,productName);
        int count=depotInService.findDepotInCount(depotInNo,empName,productName);
        return new ResultMap<List<Map>>("",depotInMasters,0,count);
    }

    //获取商品名称下拉列表
    @RequestMapping("getAllProductName")
    @ResponseBody
    public Object getDetail(){
        List<String> strings=depotInService.getAllProductName();
        System.out.println(strings);
        return strings;
    }

    //入库记录详情
    @RequestMapping("getDetailByNo/{depotInNo}")
    public String getDetailByNo(Model model, @PathVariable String depotInNo){
        Map map=depotInService.getDetailByNo(depotInNo);
        model.addAttribute("detail_map",map);
        return "depotIn/depotInDetail";
    }

}
