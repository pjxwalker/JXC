package com.aaa.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 17:13
 * 采购订单详细
 */
public class PurchaseDetail {

    private Integer detailId;//采购订单详细id
    private String purchaseNo;//采购订单编号
    private String productNo;//商品编号
    private int productNumber;//采购数量
    private BigDecimal subtotal;//小计
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作


    public Integer getDetailId() {
        return detailId;
    }

    public void setDetailId(Integer detailId) {
        this.detailId = detailId;
    }

    public String getPurchaseNo() {
        return purchaseNo;
    }

    public void setPurchaseNo(String purchaseNo) {
        this.purchaseNo = purchaseNo;
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

    public BigDecimal getSubtotal() {
        return subtotal;
    }

    public void setSubtotal(BigDecimal subtotal) {
        this.subtotal = subtotal;
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
