package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

/**
 * @Author: Zexin Ma 处理员工的CRUD请求
 * @Create: 2021-01-30-9:03
 * @Description:
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;
    /**
     * @Description 查询员工数据(分页查询)
     * @Date 2021/1/30 9:08
     * @Author Zexin Ma
     * @param
     * @return java.lang.String
     */

    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn,
                          Model model){
        //这是一个分页查询
        //引入PageHelper分页查询
        //在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);

        return "list";
    }
}
