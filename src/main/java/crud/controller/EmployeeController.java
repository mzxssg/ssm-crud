package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.cj.protocol.x.ReusableInputStream;
import crud.bean.Employee;
import crud.bean.Msg;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
     * @Description 员工更新方法
     * @Date 2021/2/2 16:01
     * @Author Zexin Ma
     * @param employee
     * @return crud.bean.Msg
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg savaEmp(Employee employee){
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    /**
     * @Description 根据id查询员工
     * @Date 2021/2/2 15:52
     * @Author Zexin Ma
     * @param id
     * @return crud.bean.Msg
     */
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id){
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }


    /**
     * @Description 检查用户名是否可用
     * @Date 2021/2/1 19:23
     * @Author Zexin Ma
     * @param empName
     * @return crud.bean.Msg
     */
    @ResponseBody
    @RequestMapping(value = "/checkUser",method = RequestMethod.GET)
    public Msg checkUser(@RequestParam("empName") String empName){
        //先判断用户名是否是合法的表达式
        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5}$)";
        if (!empName.matches(regx)){
            return Msg.fail().add("va_msg", "用户名必须是6-16位数字和字母的组合或者2-5位中文");
        }

        //数据库用户名重复校验
        boolean hasEmpName =employeeService.checkUser(empName);
        if(hasEmpName){
            return Msg.success().add("va_msg", "用户名可用");
        }else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }

    }

    /**
     * @Description 员工保存
     * @Date 2021/1/31 20:26
     * @Author Zexin Ma
     * @param
     * @return crud.bean.Msg
     */
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if (result.hasErrors()){
            //校验失败,应该返回失败,在模态框中显示校验失败的信息
            Map<String,Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                System.out.println("错误的字段名："+error.getField());
                System.out.println("错误信息："+error.getDefaultMessage());
                map.put(error.getField(), error.getDefaultMessage());
            }
            return Msg.fail().add("errorField", map);

        }else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }


    /**
     * @Description 导入jackson包
     * @Date 2021/1/31 10:39
     * @Author Zexin Ma
     * @param pn
     * @return com.github.pagehelper.PageInfo
     */
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){
        //这是一个分页查询
        //引入PageHelper分页查询
        //在查询之前只需要调用，传入页码，以及每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的这个查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageInfo包装查询后的结果,只需要将pageInfo交给页面就行了
        //封装了详细的分页信息，包括有我们查询出来的数据,传入连续显示的页数
        PageInfo page = new PageInfo(emps,5);

        return Msg.success().add("pageInfo", page);
    }


    /**
     * @Description 查询员工数据(分页查询) 这不是通用的方法，客户端种类不同就不能用了，换成
     * 了上面的方法getEmpsWithJson，这个就是通用的了，数据转成了json格式传给客户端
     * @Date 2021/1/30 9:08
     * @Author Zexin Ma
     * @param
     * @return java.lang.String
     */
//    @RequestMapping("/empsTest")
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
