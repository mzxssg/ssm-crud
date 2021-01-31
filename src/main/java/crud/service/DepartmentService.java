package crud.service;

import crud.bean.Department;
import crud.dao.DepartmentMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author: Zexin Ma
 * @Create: 2021-01-31-19:48
 * @Description:
 */
@Service
public class DepartmentService {

    @Autowired
    DepartmentMapper departmentMapper;


    public List<Department> getDepartments() {
        return departmentMapper.selectByExample(null);
    }
}
