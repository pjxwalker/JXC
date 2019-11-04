package com.aaa.entity;

import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 16:19
 * 商品类别信息
 */
public class ProductType {

    private Integer typeId;//主键id
    private String typeName;
    private String typeNo;
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作


    public Integer getTypeId() {
        return typeId;
    }

    public void setTypeId(Integer typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getTypeNo() {
        return typeNo;
    }

    public void setTypeNo(String typeNo) {
        this.typeNo = typeNo;
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
