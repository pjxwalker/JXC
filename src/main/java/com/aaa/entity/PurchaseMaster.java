package com.aaa.entity;

import java.math.BigDecimal;
import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 17:03
 * 采购订单总表
 */
public class PurchaseMaster {

    private Integer purchaseId;//采购id
    private String purchaseNo;//采购订单编号
    private String purchaser;//采购人
    private Date purchaseTime;//采购时间
    private String proposer;//申请人
    private String applyBranch;//申请部门
    private BigDecimal totalPrice;//采购总价
    private String explains;//说明

    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作


    public Integer getPurchaseId() {
        return purchaseId;
    }

    public void setPurchaseId(Integer purchaseId) {
        this.purchaseId = purchaseId;
    }

    public String getPurchaseNo() {
        return purchaseNo;
    }

    public void setPurchaseNo(String purchaseNo) {
        this.purchaseNo = purchaseNo;
    }

    public String getPurchaser() {
        return purchaser;
    }

    public void setPurchaser(String purchaser) {
        this.purchaser = purchaser;
    }

    public Date getPurchaseTime() {
        return purchaseTime;
    }

    public void setPurchaseTime(Date purchaseTime) {
        this.purchaseTime = purchaseTime;
    }

    public String getProposer() {
        return proposer;
    }

    public void setProposer(String proposer) {
        this.proposer = proposer;
    }

    public String getApplyBranch() {
        return applyBranch;
    }

    public void setApplyBranch(String applyBranch) {
        this.applyBranch = applyBranch;
    }

    public BigDecimal getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(BigDecimal totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getExplains() {
        return explains;
    }

    public void setExplains(String explains) {
        this.explains = explains;
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
