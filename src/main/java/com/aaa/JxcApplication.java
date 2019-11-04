package com.aaa;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@SpringBootApplication
@EnableTransactionManagement
@MapperScan("com.aaa.dao")
public class JxcApplication {

    public static void main(String[] args) {
        SpringApplication.run(JxcApplication.class, args);
    }

}
