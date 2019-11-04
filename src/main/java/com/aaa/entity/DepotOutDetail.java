package com.aaa.entity;

import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 18:39
 * 出库详细表
 */
public class DepotOutDetail {

    private Integer detailId;//出库详细id
    private String depotOutNo;//出库编号
    private String productNo;//产品编号
    private int productNumber;//出库数量

    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作

    public Integer getDetailId() {
        return detailId;
    }

    public void setDetailId(Integer detailId) {
        this.detailId = detailId;
    }

    public String getDepotOutNo() {
        return depotOutNo;
    }

    public void setDepotOutNo(String depotOutNo) {
        this.depotOutNo = depotOutNo;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public int getProductNumber() {
        return productNumber;
    }

    public void setProductNumber(int productNumber) {
        this.productNumber = productNumber;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
