package com.it.service;

import com.it.dao.DepartmentMapper;
import com.it.domain.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {
    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> findAll() {
        List<Department> departmentList=departmentMapper.selectByExample(null);
        return departmentList;
    }
}
