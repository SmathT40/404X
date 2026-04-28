package service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dao.InstructorSettlementDao;
import dto.Settlement;

@Service
public class InstructorSettlementService {

	@Autowired
	private InstructorSettlementDao instructorSettlementDao;
	
	public Settlement getSettlementDetail(int settle_id) {
		return instructorSettlementDao.getSettlementDetail(settle_id);
	}

	public void insertSettlement(Settlement st) {
		instructorSettlementDao.insertSettlement(st);
	}

	public int getSettlementCount(String user_id) {
		return instructorSettlementDao.getSettlementCount(user_id);
	}
	
	public List<Settlement> getSettlementList(String user_id, int offset, int pageSize) {
		return instructorSettlementDao.getSettlementList(user_id, offset, pageSize);
	}

	public void updateSettlement(Settlement st) {
		instructorSettlementDao.updateSettlement(st);
	}

	public void deleteSettlement(int settle_id) {
		instructorSettlementDao.deleteSettlement(settle_id);		
	}


}
