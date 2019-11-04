package com.aaa.entity;

import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 16:30
 * 客户基本信息
 */
public class CustomerInfo {

    private Integer cusId;//客户id
    private String cusName;//客户姓名
    private String cusShortName;//客户简称
    private String cusAddress;//客户地址
    private String cusPostCode;//客户邮箱
    private String cusPhone;//客户电话
    private String cusFax;//客户传真
    private String cusContact;//联系人
    private String cusContactPhone;//联系电话
    private String cusBank;//开户银行
    private String cusBankCard;//银行卡号
    private String cusEmail;//电子邮箱
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作

    public Integer getCusId() {
        return cusId;
    }

    public void setCusId(Integer cusId) {
        this.cusId = cusId;
    }

    public String getCusName() {
        return cusName;
    }

    public void setCusName(String cusName) {
        this.cusName = cusName;
    }

    public String getCusShortName() {
        return cusShortName;
    }

    public void setCusShortName(String cusShortName) {
        this.cusShortName = cusShortName;
    }

    public String getCusAddress() {
        return cusAddress;
    }

    public void setCusAddress(String cusAddress) {
        this.cusAddress = cusAddress;
    }

    public String getCusPostCode() {
        return cusPostCode;
    }

    public void setCusPostCode(String cusPostCode) {
        this.cusPostCode = cusPostCode;
    }

    public String getCusPhone() {
        return cusPhone;
    }

    public void setCusPhone(String cusPhone) {
        this.cusPhone = cusPhone;
    }

    public String getCusFax() {
        return cusFax;
    }

    public void setCusFax(String cusFax) {
        this.cusFax = cusFax;
    }

    public String getCusContact() {
        return cusContact;
    }

    public void setCusContact(String cusContact) {
        this.cusContact = cusContact;
    }

    public String getCusContactPhone() {
        return cusContactPhone;
    }

    public void setCusContactPhone(String cusContactPhone) {
        this.cusContactPhone = cusContactPhone;
    }

    public String getCusBank() {
        return cusBank;
    }

    public void setCusBank(String cusBank) {
        this.cusBank = cusBank;
    }

    public String getCusBankCard() {
        return cusBankCard;
    }

    public void setCusBankCard(String cusBankCard) {
        this.cusBankCard = cusBankCard;
    }

    public String getCusEmail() {
        return cusEmail;
    }

    public void setCusEmail(String cusEmail) {
        this.cusEmail = cusEmail;
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
