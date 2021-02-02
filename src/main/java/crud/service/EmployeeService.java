package crud.service;

import crud.bean.Employee;
import crud.bean.EmployeeExample;
import crud.bean.EmployeeExample.Criteria;
import crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: Zexin Ma
 * @Create: 2021-01-30-9:09
 * @Description:
 */
@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;

    /**
     * @Description 查询所有员工
     * @Date 2021/1/30 9:15
     * @Author Zexin Ma
     * @param
     * @return java.util.List<crud.bean.Employee>
     */
    public List<Employee> getAll() {
        EmployeeExample employeeExample = new EmployeeExample();
        employeeExample.setOrderByClause("emp_id");
        return employeeMapper.selectByExampleWithDept(employeeExample);
    }

    /**
     * @Description 员工保存方法
     * @Date 2021/1/31 20:28
     * @Author Zexin Ma
     * @param employee
     * @return void
     */
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    /**
     * @Description //校验用户名是否可用
     * @Date 2021/2/1 19:05
     * @Author Zexin Ma               
     * @param empName
     * @return boolean  true:代表当前姓名可用  false:代表当前姓名不可用
     */
    public boolean checkUser(String empName) {
        EmployeeExample employeeExample = new EmployeeExample();
        Criteria criteria = employeeExample.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        long count = employeeMapper.countByExample(employeeExample);
        return count == 0;
    }

    /**
     * @Description 按照员工id查询员工
     * @Date 2021/2/2 14:40
     * @Author Zexin Ma
     * @param id
     * @return crud.bean.Employee
     */
    public Employee getEmp(Integer id) {
        return employeeMapper.selectByPrimaryKey(id);
    }

    /**
     * @Description 员工更新
     * @Date 2021/2/2 16:00
     * @Author Zexin Ma
     * @param employee
     * @return void
     */
    public void updateEmp(Employee employee) {
        employeeMapper.updateByPrimaryKeySelective(employee);
    }
}
