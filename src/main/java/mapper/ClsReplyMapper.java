package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.ClsReplyDto;

@Mapper
public interface ClsReplyMapper {
	
	//0430 hto 탈퇴한 이용자 처리를 위해 LEFT JOIN으로 바꾸고 IFNULL 추가
	//원댓글(부모) 목록
	@Select("SELECT r.*, IFNULL(u.user_name, '탈퇴한 이용자') as user_name FROM cls_reply r " +
	        "LEFT JOIN users u ON r.user_id = u.user_id " + // LEFT JOIN으로 변경
	        "WHERE r.class_id = #{classId} AND r.lec_id IS NULL AND r.cls_parent_id IS NULL " +
	        "ORDER BY r.cls_reply_no DESC")
	List<ClsReplyDto> selectParentReplies(int classId);

	//대댓글(자식) 목록
	@Select("SELECT r.*, IFNULL(u.user_name, '탈퇴한 이용자') as user_name FROM cls_reply r " +
	        "LEFT JOIN users u ON r.user_id = u.user_id " + // LEFT JOIN으로 변경
	        "WHERE r.cls_parent_id = #{parentNo} " +
	        "ORDER BY r.cls_reply_no ASC")
	List<ClsReplyDto> selectChildReplies(int parentNo);

	//강의별 댓글 목록
	@Select("SELECT r.*, IFNULL(u.user_name, '탈퇴한 이용자') as user_name FROM cls_reply r " +
	        "LEFT JOIN users u ON r.user_id = u.user_id " + // LEFT JOIN으로 변경
	        "WHERE r.class_id = #{class_id} AND r.lec_id = #{lec_id} AND r.cls_parent_id IS NULL " +
	        "ORDER BY r.cls_reply_no DESC")
	List<ClsReplyDto> selectLectureParentReplies(@Param("class_id") int classId, @Param("lec_id") Integer lecId);

    // 3. 등록 //4월 27일 수정 csw
    @Insert("INSERT INTO cls_reply (user_id, class_id, lec_id, cls_reply_content, cls_reply_private, cls_parent_id, board_no) " +
            "VALUES (#{user_id}, #{class_id}, #{lec_id}, #{cls_reply_content}, #{cls_reply_private}, #{cls_parent_id}, #{board_no})")
    int insertReply(ClsReplyDto dto);

    
    @Delete("DELETE FROM cls_reply " +
            "WHERE cls_reply_no = #{id} " +
            "AND (user_id = #{userId} OR #{userRole} >= 1)")
    int delete(@Param("id") int id, 
                       @Param("userId") String userId, 
                       @Param("userRole") int userRole);
    // 04-27
 // 게시판 원댓글 목록 csw
    @Select("SELECT r.*, u.user_name FROM cls_reply r " +
            "JOIN users u ON r.user_id = u.user_id " +
            "WHERE r.board_no = #{board_no} AND r.cls_parent_id IS NULL " +
            "ORDER BY r.cls_reply_no DESC")
    List<ClsReplyDto> selectBoardParentReplies(@Param("board_no") int board_no);

    //04-27 csw
 // =========================================================================
 // --- 내가 쓴 댓글 추가 ---
 // =========================================================================
 @Select("SELECT r.cls_reply_no, r.board_no, r.cls_reply_reg_date, " +
         "b.board_title, b.board_type " +
         "FROM cls_reply r " +
         "JOIN board b ON r.board_no = b.board_no " +
         "WHERE r.user_id = #{userId} AND r.board_no IS NOT NULL " +
         "ORDER BY r.cls_reply_no DESC " +
         "LIMIT #{startrow}, #{limit}")
 List<ClsReplyDto> selectMyCommentList(@Param("userId") String userId,
                                        @Param("startrow") int startrow,
                                        @Param("limit") int limit);

 @Select("SELECT COUNT(*) FROM cls_reply WHERE user_id = #{value} AND board_no IS NOT NULL")
 int countMyComment(String userId);
    
//=========================================================================
//--- 문의사항 답글완료 처리 추가 0428 1220 csw --- 
//=========================================================================
 @Update("UPDATE board SET board_status = #{status} WHERE board_no = #{board_no}")
 void updateBoardStatus(@Param("board_no") int board_no, @Param("status") int status);
}

