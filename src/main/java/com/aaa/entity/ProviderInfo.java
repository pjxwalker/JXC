package com.aaa.entity;

import java.util.Date;

/**
 * @author 吴教鹏
 * @date 2019/7/25 15:03
 *
 * 供应商信息
 */
public class ProviderInfo {

    private Integer proId;//供应商id
    private String proName;//供应商姓名
    private String proShortName;//供应商简称
    private String proAddress;//供应商地址
    private String proPostCode;//供应商邮箱
    private String proPhone;//供应商电话
    private String proFax;//供应商传真
    private String proContact;//联系人
    private String proContactPhone;//联系人电话
    private String proBank;//开户银行
    private String proBankCard;//银行卡号
    private String proEmail;//电子邮箱
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作


    public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName;
    }

    public String getProShortName() {
        return proShortName;
    }

    public void setProShortName(String proShortName) {
        this.proShortName = proShortName;
    }

    public String getProAddress() {
        return proAddress;
    }

    public void setProAddress(String proAddress) {
        this.proAddress = proAddress;
    }

    public String getProPostCode() {
        return proPostCode;
    }

    public void setProPostCode(String proPostCode) {
        this.proPostCode = proPostCode;
    }

    public String getProPhone() {
        return proPhone;
    }

    public void setProPhone(String proPhone) {
        this.proPhone = proPhone;
    }

    public String getProFax() {
        return proFax;
    }

    public void setProFax(String proFax) {
        this.proFax = proFax;
    }

    public String getProContact() {
        return proContact;
    }

    public void setProContact(String proContact) {
        this.proContact = proContact;
    }

    public String getProContactPhone() {
        return proContactPhone;
    }

    public void setProContactPhone(String proContactPhone) {
        this.proContactPhone = proContactPhone;
    }

    public String getProBank() {
        return proBank;
    }

    public void setProBank(String proBank) {
        this.proBank = proBank;
    }

    public String getProBankCard() {
        return proBankCard;
    }

    public void setProBankCard(String proBankCard) {
        this.proBankCard = proBankCard;
    }

    public String getProEmail() {
        return proEmail;
    }

    public void setProEmail(String proEmail) {
        this.proEmail = proEmail;
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
