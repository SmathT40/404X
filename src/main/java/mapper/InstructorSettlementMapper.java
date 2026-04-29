package mapper;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import dto.Settlement;

@Mapper
public interface InstructorSettlementMapper {

	@Select("select * from settlement where settle_id = #{settle_id}")
	Settlement getSettlementDetail(int settle_id);

	@Insert("insert into settlement (user_id, target_id, pay_amount, settle_content, settle_date) "
			+ "values (#{user_id}, #{target_id}, #{pay_amount}, #{settle_content}, now())")
	void insertSettlement(Settlement st);

	@Select("select count(*) from settlement where user_id = #{user_id}")
	int getSettlementCount(String user_id);

	@Select("select * from settlement where target_id = #{target_id} "
			+ "order by settle_date desc limit #{pageSize} offset #{offset}")
	List<Settlement> getSettlementList(
			@Param("target_id") String target_id, 
			@Param("offset") int offset, 
			@Param("pageSize") int pageSize);

	@Update("update settlement set pay_amount = #{pay_amount}, "
			+ "settle_content = #{settle_content}, target_id = #{target_id} "
			+ "where settle_id = #{settle_id}")
	void updateSettlement(Settlement st);

	@Delete("delete from settlement where settle_id = #{settle_id}")
	void deleteSettlement(int settle_id);
}
