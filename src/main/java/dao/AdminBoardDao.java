package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.Board;
import mapper.AdminBoardMapper;

@Repository
public class AdminBoardDao {

    @Autowired
    private SqlSessionTemplate template;

    private Class<AdminBoardMapper> cls = AdminBoardMapper.class;

    public List<Board> adminPostList(int pageNum, int limit, String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("startrow", (pageNum - 1) * limit);
        param.put("limit", limit);
        param.put("keyword", keyword);
        return template.getMapper(cls).selectAdminPostList(param);
    }

    public int adminPostCount(String keyword) {
        Map<String, Object> param = new HashMap<>();
        param.put("keyword", keyword);
        return template.getMapper(cls).countAdminPost(param);
    }

    public void updateStatus(int board_no, int status) {
        template.getMapper(cls).updateStatus(board_no, status);
    }
}