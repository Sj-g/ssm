package com.it.controller;

import com.it.domain.Department;
import com.it.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import java.util.List;

@Controller
public class DepartmentController {
    @Autowired
    private DepartmentService departmentService;

    /**
     * 获取员工部门，返回json数据
     * @return
     */
    @RequestMapping("/depts")
    @ResponseBody
    public List<Department> deptNew() {
        List<Department> departmentList=departmentService.findAll();
        return departmentList;
    }
}
