package dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mapper.BoardMapper;
import dto.Board;

@Repository
public class BoardDao {

    @Autowired
    private SqlSessionTemplate template;
    private Class<BoardMapper> cls = BoardMapper.class;
    private Map<String, Object> param = new HashMap<>();

    public void insert(Board board) {
        template.getMapper(cls).insert(board);
    }

    public int count(int board_type, String searchtype, String searchcontent) {
        param.clear();
        param.put("board_type", board_type);
        if (searchtype != null && !searchtype.isEmpty()) {
            String[] cols = searchtype.split(",");
            if (cols.length == 2) param.put("col2", cols[1]);
            if (cols.length >= 1) param.put("col1", cols[0]);
        }
        param.put("searchcontent", searchcontent);
        return template.getMapper(cls).count(param);
    }

    public List<Board> list(int board_type, Integer pageNum, int limit, String searchtype, String searchcontent) {
        param.clear();
        param.put("board_type", board_type);
        param.put("startrow", (pageNum - 1) * limit);
        param.put("limit", limit);
        if (searchtype != null && !searchtype.isEmpty()) {
            String[] cols = searchtype.split(",");
            if (cols.length == 2) param.put("col2", cols[1]);
            if (cols.length >= 1) param.put("col1", cols[0]);
        }
        param.put("searchcontent", searchcontent);
        return template.getMapper(cls).selectList(param);
    }

    public Board selectOne(Integer board_no) {
        return template.getMapper(cls).selectOne(board_no);
    }

    public void update(Board board) {
        template.getMapper(cls).update(board);
    }

    public void delete(int board_no) {
        template.getMapper(cls).delete(board_no);
    }

    public Board prev(int board_type, int board_no) {
        return template.getMapper(cls).selectPrev(board_type, board_no);
    }

    public Board next(int board_type, int board_no) {
        return template.getMapper(cls).selectNext(board_type, board_no);
    }
}