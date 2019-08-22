package com.it.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.it.dao.EmployeeMapper;
import com.it.domain.Department;
import com.it.domain.Employee;
import com.it.domain.Msg;
import com.it.service.DepartmentService;
import com.it.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Controller
@RequestMapping("/user")
public class EmployeeController {
    @Autowired
    private EmployeeService employeeService;
    /**
     * 查询一个
     *
     * @param
     * @return
     */
    @RequestMapping("/findOne")
    @ResponseBody
    public Msg findById(String emp) {
        System.out.println(emp);
        Integer integer = Integer.parseInt(emp);
        Employee employee = employeeService.findById(integer);
        return Msg.succeed().add("emp", employee);
//        return Msg.succeed();
    }

    /**
     * 查询所有
     *
     * @param modelAndView
     * @param pn
     * @return
     */
    @RequestMapping("/employee")
    @ResponseBody
    public ModelAndView pages(ModelAndView modelAndView,
                              @RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 7);
        List<Employee> employeeList = employeeService.findAll();
        PageInfo pageInfo = new PageInfo(employeeList, 5);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.setViewName("index");
        return modelAndView;
    }

    /**
     * 保存员工数据
     *
     * @param employee
     * @return
     */
    @RequestMapping("/emp")
    @ResponseBody
    public Msg save(Employee employee) {
        String regex = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!employee.getEmpName().matches(regex)) {
            return Msg.fail().add("mes", "用户名必须是6-16位英文和数字的组合或者2-5位中文");
        }
        boolean repetition = employeeService.getEmployeeName(employee.getEmpName());
        if (repetition) {
            employeeService.insert(employee);
            return Msg.succeed();
        }
        return Msg.fail().add("mes", "用户已存在");
    }

    @RequestMapping("/update")
    @ResponseBody
    public Msg update(Employee employee) {
        int repetition = employeeService.setById(employee);
        System.out.println(repetition);
        if (repetition != -1) {
            return Msg.succeed();
        }
        return Msg.fail().add("mes", "更新失败");
    }

    /**
     * 删除并回到当前页面
     *
     * @param pn
     * @param empId
     * @param modelAndView
     * @return
     * @throws ServletException
     * @throws IOException
     */
    @RequestMapping("/empDelete")
    public ModelAndView empDelete(@RequestParam(value = "pn") Integer pn, @RequestParam(value = "empId") Integer empId, ModelAndView modelAndView) throws ServletException, IOException {
        employeeService.delete(empId);
        PageHelper.startPage(pn, 7);
        List<Employee> employeeList = employeeService.findAll();
        PageInfo pageInfo = new PageInfo(employeeList, 5);
        modelAndView.addObject("pageInfo", pageInfo);
        modelAndView.setViewName("index");
        return modelAndView;
    }

    /**
     * 测试json
     *
     * @param pn
     * @return
     */
    @RequestMapping("/test")
    @ResponseBody
    public PageInfo jacksonTest(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        PageHelper.startPage(pn, 7);
        List<Employee> employeeList = employeeService.findAll();
        PageInfo pageInfo = new PageInfo(employeeList, 5);
        return pageInfo;
    }

}
