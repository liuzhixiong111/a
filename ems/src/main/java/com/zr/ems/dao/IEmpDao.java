package com.zr.ems.dao;

import java.util.List;

import com.zr.ems.pojo.Emp;

public interface IEmpDao {

	/**
	 * 通过昵称和密码查找emp对象
	 * 
	 * @param nickname
	 * @param password
	 * @return
	 */
	Emp findEmpByNicknameAndPassword(String nickname, String password);

	/**
	 * 根据昵称判断用户是否存在
	 * 
	 * @param nickname
	 * @return
	 */
	int findEmpByNickname(String nickname);

	/**
	 * 注册员工信息
	 * 
	 * @param emp
	 */
	void registerEmp(Emp emp);
	/**
	 * 查询所有员工信息
	 * @return
	 */
	List<Emp> findEmp();
	/**
	 * 根据id删除员工信息
	 */
	void DelByid(int id);

	void UpdateByid(Emp emp);

	Emp FindByid(int id);
}
