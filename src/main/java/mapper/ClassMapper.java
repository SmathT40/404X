package mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import dto.ClassDto;
import dto.LecDto;

@Mapper
public interface ClassMapper {
	@Select("<script>" +
	        "SELECT c.*, u.user_name " +
	        "FROM cls c " +
	        "LEFT JOIN users u ON c.user_id = u.user_id " +
	        "WHERE c.cls_status = 1 " +
	        "<choose>" +
	        "  <when test='subCode != null'> AND c.category_code = #{subCode} </when>" +
	        "  <when test='catCode != null'> AND c.category_code IN (SELECT category_code FROM category WHERE parent_code = #{catCode}) </when>" +
	        "</choose>" +
	        "ORDER BY c.cls_no " + 
	        "LIMIT #{limit} OFFSET #{offset}" +
	        "</script>")
	List<ClassDto> selectClassList(Map<String, Object> params);

    @Select("<script>" +
            "SELECT COUNT(*) FROM cls c " +
            "WHERE c.cls_status = 1 " +
            "<if test='subCode != null'> AND c.category_code = #{subCode} </if>" +
            "<if test='subCode == null and catCode != null'> " +
            "  AND c.category_code IN (SELECT category_code FROM category WHERE parent_code = #{catCode}) " +
            "</if>" +
            "</script>")
    int selectClassCount(Map<String, Object> params);
    
    @Select("SELECT c.*, u.user_name FROM cls c " +
            "LEFT JOIN users u ON c.user_id = u.user_id " +
            "WHERE c.cls_status = 1 AND c.cls_featured = 1 " + // 추천된 것만
            "ORDER BY c.cls_reg_date DESC LIMIT 3")           // 최신순 3개만
    List<ClassDto> selectFeaturedList();
    
    @Select("SELECT c.*, u.user_name FROM cls c " +
            "LEFT JOIN users u ON c.user_id = u.user_id " +
            "WHERE c.class_id = #{id}") // 목록 쿼리에서 WHERE 조건만 id로
    ClassDto selectClassDetail(int id);
    
    @Select("""
    	    SELECT 
    	        l.*, 
    	        c.cls_title, 
    	        u.user_name
    	    FROM lec l
    	    JOIN cls c ON l.class_id = c.class_id
    	    JOIN users u ON c.user_id = u.user_id
    	    WHERE l.class_id = #{class_id}
    	    ORDER BY l.lec_no ASC
    	""")
    List<LecDto> selectLecList(int class_id);

    @Select("""
    	    SELECT 
    	        l.*, 
    	        c.cls_title, 
    	        u.user_name
    	    FROM lec l
    	    JOIN cls c ON l.class_id = c.class_id
    	    JOIN users u ON c.user_id = u.user_id
    	    WHERE l.lec_id = #{id}
    	""")
	LecDto selectLecOne(int id);
    
    @Select("""
    	    SELECT * FROM lec 
    	    WHERE class_id = #{class_id} AND lec_no < #{lec_no} 
    	    ORDER BY lec_no DESC LIMIT 1
    	""")
	LecDto getPrev(@Param("class_id") int id, @Param("lec_no") int no);
	
	@Select("""
		    SELECT * FROM lec 
		    WHERE class_id = #{class_id} AND lec_no > #{lec_no} 
		    ORDER BY lec_no ASC LIMIT 1
		""")
	LecDto getNext(@Param("class_id") int id, @Param("lec_no") int no);

//	@Insert("INSERT INTO cls (user_id, category_code, cls_title, cls_exp, cls_price, cls_thumbnail, cls_content) " +
//        "VALUES (#{user_id}, #{category_code}, #{cls_title}, #{cls_exp}, #{cls_price}, #{cls_thumbnail}, #{cls_content})")
//	int insertClass(ClassDto dto);
//
//	@Insert("INSERT INTO lec (lec_title,lec_time,lec_url,lec_no,lec_content,class_id) " +
//			"VALUES (#{lec_title},#{lec_time},#{lec_url},#{lec_no},#{lec_content},#{class_id})")
//	int insertLec(LecDto dto);

}