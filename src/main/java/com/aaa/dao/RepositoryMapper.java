package com.aaa.dao;

import com.aaa.entity.RepositoryAllot;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface RepositoryMapper {
    //获取仓库中的数据 ，动态查询
    List<Map> getRepositoryList(Map map);

    //获取仓库中所有记录的 数量
    int getRepositoryCount(Map map);

    //获取所有仓库类型
    List<Map> getRepositoryType();

    //通过仓库表Id 获取仓库数据
    Map ShowRepositoryById(@Param("id") Integer id);

    //通过仓库类型Id 获取其他的仓库类型
    List<Map> findOtherRepository(@Param("repositoryTypeId") Integer repositoryTypeId);

    //提交调拨申请
    int AddRepositoryAllot(@Param("repositoryAllot") RepositoryAllot repositoryAllot);

    //提交调拨申请时，修改源仓库商品的状态为： 待审核
    int updateProductStatus(@Param("repositoryAllot") RepositoryAllot repositoryAllot);

    //获取调拨申请数据
    List<Map> getRepositoryAllotList(Map map);

    //获取调拨申请的数量
    int getRepositoryAllotCount();

    //根据仓库类型Id 获取仓库名称
    String getRepositoryTypeNameById(@Param("repositoryTypeId") Integer repositoryTypeId);

    //通过仓库类型Id和商品编号，更新仓库的库存量,及更新 修改时间
    int updateProductCount(@Param("repositoryTypeId") Integer repositoryTypeId,
                           @Param("productNo") String productNo,
                           @Param("productCount") Integer productCount);

    //判断 商品 是否 已存在于 目标仓库中
    int findProductInRepository(@Param("repositoryTypeId") Integer repositoryTypeId,
                                @Param("productNo") String productNo);

    //若商品 不存在在仓库中，则新增一条记录 到仓库 中
    int AddProductToRepository(@Param("repositoryTypeId") Integer repositoryTypeId,
                               @Param("productNo") String productNo,
                               @Param("productCount") Integer productCount);

    //通过调拨申请表主键repositoryallotId ,修改批准的调申请的 状态
    int updateAllotStatus(@Param("repositoryallotId") Integer repositoryallotId);

    //通过源仓库TypeId 和 商品编号 ,修改源仓库的商品 的 状态为： 可调拨
    int returnStatus(@Param("fromRepositoryId") Integer fromRepositoryId,
                     @Param("productNo") String productNo);

}
