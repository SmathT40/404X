package service;

import org.springframework.stereotype.Service;

@Service
public class MailService {
	
	// 누가 메일 로직을 짤 지는 모르겠지만 이 안의 내용을 메일 발송 로직으로 바꾸기만 하거라 핫산!
	public void sendTempPassword(String user_email, String tempPw) {
		System.out.println("============== [메일 발송 시퀀스 발동!] ==============");
		System.out.println("삐빕! 메일 수신자를 확인 중에 있... 얘가 비번 잊은 병신입니다! : " + user_email);
		System.out.println("모지리 새끼의 임시 비밀번호는 [" + tempPw + "] 입니다!");
		System.out.println("================================================");
		
		// 자 이제 지우고 채우거라 핫산! 누가 만들게 될 지는 모르겠지만 일단 감사합니다!
		// 제가 뇌 주름이 신생아의 그것과 비슷하여 메일 발송은 다 잊어버렸습니다!
	}
}
