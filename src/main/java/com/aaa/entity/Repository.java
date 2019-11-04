package com.aaa.entity;

import java.util.Date;

public class Repository {
    private int id ;
    private String productNo;
    private int productCount;
    private int repositoryTypeId;
    private Date createTime;
    private Date updateTime;

    public Repository() {
        super();
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public int getProductCount() {
        return productCount;
    }

    public void setProductCount(int productCount) {
        this.productCount = productCount;
    }

    public int getRepositoryTypeId() {
        return repositoryTypeId;
    }

    public void setRepositoryTypeId(int repositoryTypeId) {
        this.repositoryTypeId = repositoryTypeId;
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
        return "Repository{" +
                "id=" + id +
                ", productNo='" + productNo + '\'' +
                ", productCount=" + productCount +
                ", repositoryTypeId=" + repositoryTypeId +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
