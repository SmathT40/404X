package service;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import dto.myClassDto;
import mapper.MyClassroomMapper;
@Service
public class UserClassroomService {
	@Autowired
	private MyClassroomMapper myClassroomMapper;

	public List<myClassDto> getList(String user_id) {
        List<myClassDto> list = myClassroomMapper.selectMyClass(user_id);
//        LocalDate today = LocalDate.now();

        for (myClassDto dto : list) {
            if (dto.getCls_statereg_date() != null) {
                // 1. 수강 신청일 파싱 (DB 타입이 String이거나 Timestamp일 경우에 따라 조정)
                // 만약 String(YYYY-MM-DD HH:mm:ss)이라면 앞의 10자리만 사용
                LocalDate startDate = LocalDate.parse(dto.getCls_statereg_date().substring(0, 10));
                
                // 2. 종료일 계산 (신청일 + 수강가능일수)
                LocalDate endDate = startDate.plusDays(dto.getCls_exp());
                dto.setCls_end_date(endDate.toString());

                // 3. 남은 일수 계산 (오늘 기준)
//                long daysLeft = ChronoUnit.DAYS.between(today, endDate);
//                dto.setD_day(daysLeft);
                
                // 💡 만약 daysLeft가 0보다 작으면 자동으로 '만료' 상태로 간주하는 로직을 
                // 여기서 추가하여 cls_state_status를 3으로 임시 변경할 수도 있습니다.
            }
        }
        return list;
    }
	public boolean checkEnrollment(String user_id, int class_id) {
		// 1. 매퍼를 통해 해당 유저의 특정 강의 수강 정보(상태, 날짜 등)를 가져옴
	    myClassDto enrollment = myClassroomMapper.selectEnrollmentCheck(user_id, class_id);

	    // 2. 데이터가 없으면 수강생이 아님
	    if (enrollment == null) {
	        return false;
	    }

	    // 3. 수강 기간 체크 (오늘 날짜가 종료일 이전인지 확인)
	    LocalDate today = LocalDate.now();
	    LocalDate startDate = LocalDate.parse(enrollment.getCls_statereg_date().substring(0, 10));
	    LocalDate endDate = startDate.plusDays(enrollment.getCls_exp());

	    // 오늘이 종료일보다 이전이거나 같고, 상태가 수강중(1) 또는 완강(2)인 경우만 true
	    return !today.isAfter(endDate) && (enrollment.getCls_state_status() == 1);
	}
}
