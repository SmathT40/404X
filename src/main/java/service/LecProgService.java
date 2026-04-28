package service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import dto.LecProgDto;
import mapper.LecProgMapper;

@Service
public class LecProgService {
	@Autowired
	private LecProgMapper lecProgMapper;
	
	@Transactional
	public void upsertProgress(LecProgDto dto) {
		lecProgMapper.upsertProg(dto);
	}

}
