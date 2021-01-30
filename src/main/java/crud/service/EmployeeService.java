package crud.service;

import crud.bean.Employee;
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
        return employeeMapper.selectByExampleWithDept(null);
    }
}
