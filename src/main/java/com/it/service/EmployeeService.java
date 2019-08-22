package com.it.service;

import com.it.dao.EmployeeMapper;
import com.it.domain.Employee;
import com.it.domain.EmployeeExample;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {
    @Autowired
    private EmployeeMapper employeeMapper;
    public List<Employee> findAll() {
        List<Employee> employeeList=employeeMapper.selectByExampleWithDep(null);
        return  employeeList;
    }

    public void insert(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    public void delete(Integer Id) {
        employeeMapper.deleteByPrimaryKey(Id);
    }

    public boolean getEmployeeName(String empName) {
        EmployeeExample employeeExample=new EmployeeExample();
        EmployeeExample.Criteria criteria=employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        List<Employee> employee=employeeMapper.selectByExample(employeeExample);
        if(employee.size()==0){
            return true;
        }
        return false;
    }

    public Employee findById(Integer id) {
        Employee employee=employeeMapper.selectByPrimaryKeyWithDep(id);
        return employee;
    }

    public int setById(Employee employee) {
        int s=employeeMapper.updateByPrimaryKeySelective(employee);
        return s;
    }
}
