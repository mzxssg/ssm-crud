package crud.controller;

import crud.bean.Department;
import crud.bean.Msg;
import crud.service.DepartmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import sun.plugin2.message.GetAppletMessage;

import java.util.List;

/**
 * @Author: Zexin Ma
 * @Create: 2021-01-31-19:44
 * @Description: 处理和部门有关的请求
 */
@Controller
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    //返回所有的部门信息
    @RequestMapping("/depts")
    @ResponseBody
    public Msg getDepts(){
        List<Department> departments = departmentService.getDepartments();
        return Msg.success().add("depts", departments);
    }

}