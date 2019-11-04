package com.aaa.entity;

import java.util.Date;
import java.util.List;

/**
 * @author 吴教鹏
 * @date 2019/7/25 19:44
 * 用户权限信息
 */
public class EmpFunction {

    private Integer funId;
    private String funName;//权限名称
    private Integer funParent;//父亲结点
    private String funPath;//功能路径
    private Date createTime;//创建时间，不需要进行任何操作
    private Date updateTime;//修改时间，不需要进行任何操作


    public Integer getFunId() {
        return funId;
    }

    public void setFunId(Integer funId) {
        this.funId = funId;
    }

    public String getFunName() {
        return funName;
    }

    public void setFunName(String funName) {
        this.funName = funName;
    }

    public Integer getFunParent() {
        return funParent;
    }

    public void setFunParent(Integer funParent) {
        this.funParent = funParent;
    }

    public String getFunPath() {
        return funPath;
    }

    public void setFunPath(String funPath) {
        this.funPath = funPath;
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
