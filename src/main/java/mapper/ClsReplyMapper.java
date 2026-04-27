package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.ClsReplyDto;

@Mapper
public interface ClsReplyMapper {
	// 1. 원댓글(부모) 목록: 이름(user_name)까지 포함해서 최신순으로
	@Select("SELECT r.*, u.user_name FROM cls_reply r " +
            "JOIN users u ON r.user_id = u.user_id " +
            "WHERE r.class_id = #{classId} AND r.lec_id IS NULL AND r.cls_parent_id IS NULL " +
            "ORDER BY r.cls_reply_no DESC")
    List<ClsReplyDto> selectParentReplies(int classId);

    // 2. 대댓글(자식) 목록: 이름(user_name) 포함, 대댓글은 등록순(ASC)으로
    @Select("SELECT r.*, u.user_name FROM cls_reply r " +
            "JOIN users u ON r.user_id = u.user_id " +
            "WHERE r.cls_parent_id = #{parentNo} " +
            "ORDER BY r.cls_reply_no ASC")
    List<ClsReplyDto> selectChildReplies(int parentNo);
    
    @Select("SELECT r.*, u.user_name FROM cls_reply r " +
            "JOIN users u ON r.user_id = u.user_id " +
            "WHERE r.class_id = #{class_id} AND r.lec_id = #{lec_id} AND r.cls_parent_id IS NULL " +
            "ORDER BY r.cls_reply_no DESC")
    List<ClsReplyDto> selectLectureParentReplies(@Param("class_id") int classId, @Param("lec_id") Integer lecId);

    // 3. 등록
    @Insert("INSERT INTO cls_reply (user_id, class_id, lec_id, cls_reply_content, cls_reply_private, cls_parent_id) " +
            "VALUES (#{user_id}, #{class_id}, #{lec_id}, #{cls_reply_content}, #{cls_reply_private}, #{cls_parent_id})")
    int insertReply(ClsReplyDto dto);

    
    @Delete("DELETE FROM cls_reply " +
            "WHERE cls_reply_no = #{id} " +
            "AND (user_id = #{userId} OR #{userRole} >= 1)")
    int delete(@Param("id") int id, 
                       @Param("userId") String userId, 
                       @Param("userRole") int userRole);
    
}

