package com.aaa.service;

import com.aaa.entity.RepositoryAllot;

import java.util.List;
import java.util.Map;

public interface RepositoryService {
    //获取仓库中的数据 ，动态查询
    List<Map> getRepositoryList(Map map);
    //获取仓库中所有记录的 数量
    int getRepositoryCount(Map map);
    //获取所有仓库类型
    List<Map> getRepositoryType();
    //通过仓库表Id 获取仓库数据
    Map ShowRepositoryById(Integer id);
    //通过仓库类型Id 获取其他的仓库类型
    List<Map> findOtherRepository(Integer repositoryTypeId);

    //提交调拨申请, 并修改源仓库商品的状态为： 待审核
    boolean AddRepositoryAllot(RepositoryAllot repositoryAllot);


    //获取调拨申请数据
    List<Map> getRepositoryAllotList(Map map);
    //获取调拨申请的数量
    int getRepositoryAllotCount();
    //根据仓库类型Id 获取仓库名称
    String getRepositoryTypeNameById(Integer repositoryTypeId);

    /*
    该方法 执行调拨操作业务，先减少源仓库中对应的调拨量，再增加目标仓库对应的调拨量(或 仓库中不存在调拨的商品，则 新增商品到 仓库)，
    最后更新调拨单的 状态 为已调拨，更新 源仓库的商品 状态为 可调拨
     */
    boolean DoAllot(Integer repositoryallotId, Integer fromRepositoryId,
                    Integer toRepositoryId, String productNo, Integer allotCount);

}
