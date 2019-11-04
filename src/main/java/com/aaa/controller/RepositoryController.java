package com.aaa.controller;

import com.aaa.entity.RepositoryAllot;
import com.aaa.service.RepositoryService;
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
@RequestMapping(value = "/repository")
public class RepositoryController {
    @Resource
    private RepositoryService repositoryService;

    /*
    获取仓库中的商品数据
     */
    @RequestMapping(value = "/getRepositoryList")
    @ResponseBody
    public Object getRepositoryList(@RequestParam(value="page",required = false)Integer page,
                                    @RequestParam(value="limit",required = false)Integer limit,
                                    @RequestParam(value="repositoryTypeName",required = false)String repositoryTypeName,
                                    @RequestParam(value="productNo",required = false)String productNo,
                                    @RequestParam(value="productName",required = false)String productName,
                                    @RequestParam(value="typeNo",required = false)String typeNo){
        Map<String,Object> map = new HashMap<>();
        map.put("start",(page-1)*limit);
        map.put("limit",limit);
        map.put("repositoryTypeName",repositoryTypeName);
        map.put("productNo",productNo);
        map.put("productName",productName);
        map.put("typeNo",typeNo);
        List<Map> mapList=repositoryService.getRepositoryList(map);
        int count=repositoryService.getRepositoryCount(map);
        return new ResultMap<List<Map>>("",mapList,0,count);

    }

   /*
   获取调拨请求的数据
    */
    @RequestMapping(value = "/getRepositoryAllotList")
    @ResponseBody
    public Object getRepositoryAllotList(@RequestParam(value="page",required = false)Integer page,
                                    @RequestParam(value="limit",required = false)Integer limit){
        Map<String,Object> map1 = new HashMap<>();
        map1.put("start",(page-1)*limit);
        map1.put("limit",limit);
        List<Map> mapList=repositoryService.getRepositoryAllotList(map1);
        int count=repositoryService.getRepositoryAllotCount();

        for (int i=0 ;i<mapList.size() ; i++){
            String fromRepositoryName =repositoryService.getRepositoryTypeNameById((int)mapList.get(i).get("fromRepositoryId"));
            String toRepositoryName=repositoryService.getRepositoryTypeNameById((int)mapList.get(i).get("toRepositoryId"));
            mapList.get(i).put("fromRepositoryName",fromRepositoryName);   //源仓库名称
            mapList.get(i).put("toRepositoryName",toRepositoryName);       //目标仓库名称
        }

        return new ResultMap<List<Map>>("",mapList,0,count);

    }

//    获取仓库分类
    @RequestMapping(value = "/getRepositoryType")
    @ResponseBody
    public Object getRepositoryType(){ return repositoryService.getRepositoryType(); }

    //加载仓库商品详细信息页面
    @RequestMapping(value = "/showRepository/{id}")
    public String showRepository(Model model, @PathVariable Integer id){
        Map map=repositoryService.ShowRepositoryById(id);
        model.addAttribute("RepositoryProduct",map);
        return "repository/showrepository";
    }
    //加载商品调拨页面
    @RequestMapping(value = "/repositoryChange/{id}")
    public String repositoryChange(Model model, @PathVariable Integer id){
        Map map=repositoryService.ShowRepositoryById(id);
        model.addAttribute("repositoryChange",map);
        return "repository/repositoryChange";
    }

    /*
    加载源仓库之外的 仓库
     */
    @RequestMapping(value = "/findOtherRepository")
    @ResponseBody
    public Object findOtherRepository(@RequestParam(value = "repositoryTypeId")Integer repositoryTypeId){
        return repositoryService.findOtherRepository(repositoryTypeId);
    }

    /*
    提交调拨申请
     */
    @RequestMapping(value = "/ApplyChange")
    @ResponseBody
    public String ApplyChange(RepositoryAllot repositoryAllot){
        boolean flag = repositoryService.AddRepositoryAllot(repositoryAllot);
        if(flag){
            return "true";
        }
        return "false";
    }

    /*
    //执行调拨操作
     */
    @RequestMapping(value = "/DoAllot")
    @ResponseBody
    public String DoAllot(@RequestParam(value = "repositoryallotId")Integer repositoryallotId,
                          @RequestParam(value = "fromRepositoryId")Integer fromRepositoryId,
                          @RequestParam(value = "toRepositoryId")Integer toRepositoryId,
                          @RequestParam(value = "productNo")String productNo,
                          @RequestParam(value = "allotCount")Integer allotCount){
        boolean flag = repositoryService.DoAllot(repositoryallotId,fromRepositoryId,toRepositoryId,productNo,allotCount);
        if(flag){
            return "true";
        }
        return "false";
    }

}
