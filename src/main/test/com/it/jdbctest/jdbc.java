package com.it.jdbctest;

import com.github.pagehelper.PageInfo;
import com.it.dao.EmployeeMapper;
import com.it.domain.Employee;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations ={"classpath:applicationContext.xml","classpath:springmvc.xml"})
public class jdbc {

   @Autowired
    private WebApplicationContext context;

    private MockMvc mockmvc;

    @Before
    public void testBefore() {
        mockmvc = MockMvcBuilders.webAppContextSetup(context).build();
    }

    @Test
    public void testGoList() throws Exception {
        MvcResult result = mockmvc.perform(MockMvcRequestBuilders.get("/user/findOne").param("pn", "5")).andReturn();
        MockHttpServletRequest request = result.getRequest();
        PageInfo pi = (PageInfo) request.getAttribute("pageInfo");
        System.out.println("当前页码: " + pi.getPageNum());
        System.out.println("总页码: " + pi.getPages());
        System.out.println("总记录数: " + pi.getTotal());
        int[] nums = pi.getNavigatepageNums();
        for (int i : nums) {
            System.out.println(" " + i);
        }
        // 获取员工数据
        List<Employee> list = pi.getList();
        for (Employee employee : list) {
            System.out.println("ID: " + employee.getEmpId() + ", name: " + employee.getEmpName());
        }
    }
}
