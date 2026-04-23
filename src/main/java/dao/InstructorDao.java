package dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.Instructor;

@Repository
public class InstructorDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public List<Instructor> getInstructorList() {
		return sqlSession.selectList("instructor.getInstructorList");
	}
}
