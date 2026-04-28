package dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import dto.Settlement;
import mapper.InstructorSettlementMapper;

@Repository
public class InstructorSettlementDao {

	@Autowired
	private InstructorSettlementMapper instructorSettlementMapper;
	
	public Settlement getSettlementDetail(int settle_id) {
		return instructorSettlementMapper.getSettlementDetail(settle_id);
	}

	public void insertSettlement(Settlement st) {
		instructorSettlementMapper.insertSettlement(st);
	}

	public int getSettlementCount(String user_id) {
		return instructorSettlementMapper.getSettlementCount(user_id);
	}
	
	public List<Settlement> getSettlementList(String user_id, int offset, int pageSize) {
		return instructorSettlementMapper.getSettlementList(user_id, offset, pageSize);
	}

	public void updateSettlement(Settlement st) {
		instructorSettlementMapper.updateSettlement(st);
	}

	public void deleteSettlement(int settle_id) {
		instructorSettlementMapper.deleteSettlement(settle_id);		
	}
}
