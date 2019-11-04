package com.aaa.dao;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.SelectProvider;
import org.apache.ibatis.jdbc.SQL;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

@Repository
@Mapper
public interface DepotInMapper {

    /**
     * 分页查询入库记录
     * @param start
     * @param limit
     * @param depotInNo
     * @param empName
     * @param productName
     * @return
     */
    @SelectProvider(type = DepotInDaoProvider.class,method = "findDepotInList")
    List<Map> findDepotInList(@Param("start") Integer start,
                              @Param("limit")Integer limit,
                              @Param("depotInNo")String depotInNo,
                              @Param("empName")String empName,
                              @Param("productName")String productName
    );

    /**
     * 获取所有商品名称
     * @return
     */
    @Select("select productName from product_info")
    List<String> getAllProductName();

    /**
     * 获取入库记录行数
     */
    @SelectProvider(type = DepotInDaoProvider.class,method = "findDepotInCount")
    public int findDepotInCount(@Param("depotInNo")String depotInNo,
                                @Param("empName")String empName,
                                @Param("productName")String productName);


    //查看入库详情
    @Select("SELECT did.depotInNo,ei.empName,pi.productName,pi.productNo,pi.productSize,did.productNumber,pi.productUnit,pi.productInPrice,pi.productPlace,dim.depotInTime\n" +
            "FROM depot_in_master dim \n" +
            "JOIN depot_in_detail did ON dim.depotInNo=did.depotInNo \n" +
            "JOIN product_info pi ON pi.productNo=did.productNo \n" +
            "JOIN employee_info ei ON ei.empId=dim.empId\n" +
            "where did.depotInNo=#{depotInNo}")
    public Map getDetailByNo(@Param("depotInNo")String depotInNo);


    //sql语句构造器
    class DepotInDaoProvider {

        public String findDepotInList(Integer start,Integer limit,String depotInNo,String empName,String productName) {
            String sql=new SQL(){{
                SELECT("dim.depotInId,dim.depotInNo,ei.empName, pi.productName,dim.depotInTime");
                FROM("depot_in_master dim");
                JOIN("depot_in_detail ON dim.depotInNo=depot_in_detail.depotInNo");
                JOIN("product_info pi ON pi.productNo=depot_in_detail.productNo");
                JOIN("employee_info ei ON ei.empId=dim.empId");
                if(depotInNo!=null && depotInNo!=""){
                    System.out.println(depotInNo);
                    WHERE("dim.depotInNo LIKE CONCAT('%',#{depotInNo},'%')");//#{depotInNo}
                }
                if(empName!=null && empName!=""){
                    WHERE("ei.empName LIKE CONCAT('%',#{empName},'%')");
                }
                if(productName!=null && productName!=""){
                    WHERE("pi.productName LIKE CONCAT('%',#{productName},'%')");
                }
            }}.toString();
            if(start!=null && limit!=null){
                sql+=" LIMIT #{start},#{limit}";
            }
            return sql;
        }

        public String findDepotInCount(String depotInNo,String empName,String productName){
            return new SQL(){{
                SELECT("count(dim.depotInId)");
                FROM("depot_in_master dim");
                JOIN("depot_in_detail ON dim.depotInNo=depot_in_detail.depotInNo");
                JOIN("product_info pi ON pi.productNo=depot_in_detail.productNo");
                JOIN("employee_info ei ON ei.empId=dim.empId");
                if(depotInNo!=null && depotInNo!=""){
                    System.out.println(depotInNo);
                    WHERE("dim.depotInNo LIKE CONCAT('%',#{depotInNo},'%')");//#{depotInNo}
                }
                if(empName!=null && empName!=""){
                    WHERE("ei.empName LIKE CONCAT('%',#{empName},'%')");
                }
                if(productName!=null && productName!=""){
                    WHERE("pi.productName LIKE CONCAT('%',#{productName},'%')");
                }
            }}.toString();
        }
    }
}
