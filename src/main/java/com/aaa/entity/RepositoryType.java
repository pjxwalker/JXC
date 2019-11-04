package com.aaa.entity;

import java.util.Date;

public class RepositoryType {
    private int repositoryTypeId;
    private String repositoryTypeName;
    private Date createTime;
    private Date updateTime;

    public RepositoryType() {
        super();
    }

    public int getRepositoryTypeId() {
        return repositoryTypeId;
    }

    public void setRepositoryTypeId(int repositoryTypeId) {
        this.repositoryTypeId = repositoryTypeId;
    }

    public String getRepositoryTypeName() {
        return repositoryTypeName;
    }

    public void setRepositoryTypeName(String repositoryTypeName) {
        this.repositoryTypeName = repositoryTypeName;
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
        return "RepositoryType{" +
                "repositoryTypeId=" + repositoryTypeId +
                ", repositoryTypeName='" + repositoryTypeName + '\'' +
                ", createTime=" + createTime +
                ", updateTime=" + updateTime +
                '}';
    }
}
