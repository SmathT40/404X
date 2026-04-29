package mapper;

import java.util.List;
import java.util.Map;
import org.apache.ibatis.annotations.*;
import dto.Board;

public interface BoardMapper {

	String select = "SELECT board_no, board_title, board_content, board_private, "
            + "board_file_path as fileurl, user_id, board_reg_date, board_cnt, board_status, board_type, board_featured "
            + "FROM board";

    @Options(useGeneratedKeys = true, keyProperty = "board_no")
    @Insert("INSERT INTO board (board_title, board_content, board_private, board_file_path, user_id, board_type, board_reg_date, board_featured) "
    	      + "VALUES (#{board_title}, #{board_content}, #{board_private}, #{fileurl}, #{user_id}, #{board_type}, NOW(), #{board_featured})")
    	void insert(Board board);
    @Select({"<script>",
        "SELECT COUNT(*) FROM board WHERE board_type = #{board_type}",
        "<if test='col1 != null and col2 == null'> AND ${col1} LIKE CONCAT('%', #{searchcontent}, '%') </if>",
        "<if test='col1 != null and col2 != null'> AND (${col1} LIKE CONCAT('%', #{searchcontent}, '%') OR ${col2} LIKE CONCAT('%', #{searchcontent}, '%')) </if>",
        "</script>"})
    int count(Map<String, Object> param);

    @Select({"<script>",
        select + " WHERE board_type = #{board_type}",
        "<if test='col1 != null and col2 == null'> AND ${col1} LIKE CONCAT('%', #{searchcontent}, '%') </if>",
        "<if test='col1 != null and col2 != null'> AND (${col1} LIKE CONCAT('%', #{searchcontent}, '%') OR ${col2} LIKE CONCAT('%', #{searchcontent}, '%')) </if>",
        "ORDER BY board_featured desc, board_no DESC LIMIT #{startrow}, #{limit}",
        "</script>"})
    List<Board> selectList(Map<String, Object> param);

    @Select(select + " WHERE board_no = #{value}")
    Board selectOne(Integer board_no);

    @Update("UPDATE board SET board_title=#{board_title}, board_content=#{board_content}, "
    	      + "board_private=#{board_private}, board_file_path=#{fileurl}, board_featured=#{board_featured} WHERE board_no=#{board_no}")
    	void update(Board board);

    @Delete("DELETE FROM board WHERE board_no=#{value}")
    void delete(int board_no);

    @Select("SELECT board_no, board_title FROM board WHERE board_type = #{board_type} AND board_no < #{board_no} ORDER BY board_no DESC LIMIT 1")
    Board selectPrev(@Param("board_type") int board_type, @Param("board_no") int board_no);

    @Select("SELECT board_no, board_title FROM board WHERE board_type = #{board_type} AND board_no > #{board_no} ORDER BY board_no ASC LIMIT 1")
    Board selectNext(@Param("board_type") int board_type, @Param("board_no") int board_no);
    
 // 내가 쓴 게시글 목록
    @Select("SELECT board_no, board_title, board_type, board_reg_date FROM board " +
            "WHERE user_id = #{userId} AND board_type IN (1, 3) ORDER BY board_no DESC " +
            "LIMIT #{startrow}, #{limit}")
    List<Board> selectMyPostList(@Param("userId") String userId,
                                  @Param("startrow") int startrow,
                                  @Param("limit") int limit);

    // 내가 쓴 게시글 수
    @Select("SELECT COUNT(*) FROM board WHERE user_id = #{userId} AND board_type IN (1, 3)")
    int countMyPost(@Param("userId") String userId);
}
