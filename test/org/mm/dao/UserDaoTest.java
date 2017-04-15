package org.mm.dao;

import org.mm.dao.UserDao;
import org.mm.model.Question;
import org.mm.model.User;

import junit.framework.TestCase;

public class UserDaoTest extends TestCase {

	private UserDao userDao = new UserDao();
	public void testSave() {
		User user=new User();
		Question q = new Question();
		user.setId("lisi");
		user.setName("李四");
		user.setPassword("123456");
		user.setMobile("123546789");
		user.setNick("三儿");
		q.setId("01");
		q.setAnswer("1315456");
		user.setQuestion(q);

		userDao.save(user);
		

	}
	
public void testGet() {
		
		User user=this.userDao.get("zhangsan");
		
		System.out.println(user);
	}
	
public void testUpdate() {
		
		User user=new User();
		user.setId("lisi");
		user.setName("李三1");
		user.setNick("wb1");
		user.setMobile("155105071832");
		user.setPassword("wangbo1");
		
		Question q=new Question();
		q.setId("02");
		q.setAnswer("15510507182");
		user.setQuestion(q);
		
		userDao.update(user);
	}

}
