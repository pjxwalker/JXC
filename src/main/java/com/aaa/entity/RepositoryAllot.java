package com.aaa.entity;

import java.util.Date;

public class RepositoryAllot {
    private int id;
    private int fromRepositoryId;
    private int toRepositoryId;
    private String productNo;
    private int allotCount;
    private int statusId;
    private Date createTime;
    private Date updateTime;

    private String fromRepositoryName;   //源仓库
    private String toRepositoryName;     //目标仓库

    public RepositoryAllot() {
        super();
    }

    public String getFromRepositoryName() {
        return fromRepositoryName;
    }

    public void setFromRepositoryName(String fromRepositoryName) {
        this.fromRepositoryName = fromRepositoryName;
    }

    public String getToRepositoryName() {
        return toRepositoryName;
    }

    public void setToRepositoryName(String toRepositoryName) {
        this.toRepositoryName = toRepositoryName;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getFromRepositoryId() {
        return fromRepositoryId;
    }

    public void setFromRepositoryId(int fromRepositoryId) {
        this.fromRepositoryId = fromRepositoryId;
    }

    public int getToRepositoryId() {
        return toRepositoryId;
    }

    public void setToRepositoryId(int toRepositoryId) {
        this.toRepositoryId = toRepositoryId;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public int getAllotCount() {
        return allotCount;
    }

    public void setAllotCount(int allotCount) {
        this.allotCount = allotCount;
    }

    public int getStatusId() {
        return statusId;
    }

    public void setStatusId(int statusId) {
        this.statusId = statusId;
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

    @Override
    public String toString() {
        return "RepositoryAllot{" +
                "id=" + id +
                ", fromRepositoryId=" + fromRepositoryId +
                ", toRepositoryId=" + toRepositoryId +
                ", productNo='" + productNo + '\'' +
                ", allotCount=" + allotCount +
                ", statusId=" + statusId +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
