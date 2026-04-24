package mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.*;
import dto.Board;

@Mapper
public interface AdminBoardMapper {

    @Select("<script>" +
            "SELECT board_no, board_title, user_id, board_type, board_reg_date, board_status " +
            "FROM board " +
            "<if test='keyword != null and keyword != \"\"'>" +
            "WHERE board_title LIKE CONCAT('%', #{keyword}, '%') " +
            "</if>" +
            "ORDER BY board_no DESC " +
            "LIMIT #{startrow}, #{limit}" +
            "</script>")
    List<Board> selectAdminPostList(Map<String, Object> param);

    @Select("<script>" +
            "SELECT COUNT(*) FROM board " +
            "<if test='keyword != null and keyword != \"\"'>" +
            "WHERE board_title LIKE CONCAT('%', #{keyword}, '%') " +
            "</if>" +
            "</script>")
    int countAdminPost(Map<String, Object> param);

    @Update("UPDATE board SET board_status = #{status} WHERE board_no = #{board_no}")
    void updateStatus(@Param("board_no") int board_no, @Param("status") int status);
}