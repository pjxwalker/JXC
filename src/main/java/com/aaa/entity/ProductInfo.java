package com.aaa.entity;

import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 16:36
 * 产品基本信息
 */
public class ProductInfo {

    private Integer productId;//
    private String productNo;//产品编号
    private String productName;//产品名称
    private String productShortName;//产品简称
    private String productSize;//产品规格
    private String typeNo;//类目编号
    private String productInPrice;//进价
    private String productOutPrice;//售价
    private String productRetailPrice;//建议零售价
    private String productPlace;//产地
    private String productUnit;//计量单位
    private Integer productCount;//产品库存
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作


    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public String getProductNo() {
        return productNo;
    }

    public void setProductNo(String productNo) {
        this.productNo = productNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductShortName() {
        return productShortName;
    }

    public void setProductShortName(String productShortName) {
        this.productShortName = productShortName;
    }

    public String getProductSize() {
        return productSize;
    }

    public void setProductSize(String productSize) {
        this.productSize = productSize;
    }

    public String getTypeNo() {
        return typeNo;
    }

    public void setTypeNo(String typeNo) {
        this.typeNo = typeNo;
    }

    public String getProductInPrice() {
        return productInPrice;
    }

    public void setProductInPrice(String productInPrice) {
        this.productInPrice = productInPrice;
    }

    public String getProductOutPrice() {
        return productOutPrice;
    }

    public void setProductOutPrice(String productOutPrice) {
        this.productOutPrice = productOutPrice;
    }

    public String getProductRetailPrice() {
        return productRetailPrice;
    }

    public void setProductRetailPrice(String productRetailPrice) {
        this.productRetailPrice = productRetailPrice;
    }

    public String getProductPlace() {
        return productPlace;
    }

    public void setProductPlace(String productPlace) {
        this.productPlace = productPlace;
    }

    public String getProductUnit() {
        return productUnit;
    }

    public void setProductUnit(String productUnit) {
        this.productUnit = productUnit;
    }

    public Integer getProductCount() {
        return productCount;
    }

    public void setProductCount(Integer productCount) {
        this.productCount = productCount;
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
