package com.aaa.service;


import com.aaa.dao.RepositoryMapper;
import com.aaa.entity.RepositoryAllot;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Service
public class RepositoryServiceImpl implements RepositoryService{
    @Resource
    private RepositoryMapper repositoryMapper;
    private int allot;

    @Override
    public List<Map> getRepositoryList(Map map) { return repositoryMapper.getRepositoryList(map); }

    @Override
    public int getRepositoryCount(Map map) { return repositoryMapper.getRepositoryCount(map); }

    @Override
    public List<Map> getRepositoryType() { return repositoryMapper.getRepositoryType(); }

    @Override
    public Map ShowRepositoryById(Integer id) { return repositoryMapper.ShowRepositoryById(id); }

    @Override
    public List<Map> findOtherRepository(Integer repositoryTypeId) {
        return repositoryMapper.findOtherRepository(repositoryTypeId); }

    @Override
    public boolean AddRepositoryAllot(RepositoryAllot repositoryAllot) {
        int count1 = repositoryMapper.AddRepositoryAllot(repositoryAllot);
        if(count1 > 0 ){
//            System.out.println("提交调拨申请成功！");
            int count2 = repositoryMapper.updateProductStatus(repositoryAllot);
            if (count2 > 0 ){
//                System.out.println("修改源仓库商品的状态为： 待审核");
                return true;
            }
        }
        return false;
    }

    @Override
    public List<Map> getRepositoryAllotList(Map map) { return repositoryMapper.getRepositoryAllotList(map); }

    @Override
    public int getRepositoryAllotCount() { return repositoryMapper.getRepositoryAllotCount(); }

    @Override
    public String getRepositoryTypeNameById(Integer repositoryTypeId) {
        return repositoryMapper.getRepositoryTypeNameById(repositoryTypeId);
    }

    @Override
    public boolean DoAllot(Integer repositoryallotId, Integer fromRepositoryId,
                           Integer toRepositoryId, String productNo, Integer allotCount) {
        //先减少源仓库中对应的调拨量(传来的allotCount 用负数传到 mapper)
        int count1 = repositoryMapper.updateProductCount(fromRepositoryId,productNo, - allotCount);
        if (count1 > 0){
//            System.out.println("更新 源仓库的库存量");
            //判断 商品 是否 已存在于 目标仓库中
            if(repositoryMapper.findProductInRepository(toRepositoryId,productNo) > 0 ){
                //商品已存在,更新目标仓库 的库存量
                int count2 = repositoryMapper.updateProductCount(toRepositoryId,productNo,allotCount);
                if (count2 > 0){
//                    System.out.println("更新 目标仓库的库存量");
                    //最后修改 调拨单 的 状态
                    int count3 = repositoryMapper.updateAllotStatus(repositoryallotId);
                    if (count3 > 0 ){
//                        System.out.println("修改 调拨单的状态为：已调拨");
                        int count4 = repositoryMapper.returnStatus(fromRepositoryId,productNo);
                        if (count4 > 0 ){
//                            System.out.println("修改 源仓库商品的状态为：可调拨");
                            return true;
                        }

                    }

                }
            }else {
                //商品不存在,直接新增商品到 目标仓库中
                int count2 = repositoryMapper.AddProductToRepository(toRepositoryId,productNo,allotCount);
                if (count2 > 0){
//                    System.out.println("商品不存在,新增了一条记录到仓库");
                    int count3 = repositoryMapper.updateAllotStatus(repositoryallotId);
                    if (count3 > 0 ){
//                        System.out.println("修改 调拨单的状态为：已调拨");
                        int count4 = repositoryMapper.returnStatus(fromRepositoryId,productNo);
                        if (count4 > 0 ){
//                            System.out.println("修改 源仓库商品的状态为：可调拨");
                            return true;
                        }

                    }
                }
            }

        }

        return false;
    }


}
