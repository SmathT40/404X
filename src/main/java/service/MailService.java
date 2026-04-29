package service;

import java.util.List;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.springframework.stereotype.Service;

@Service
public class MailService {

    private static final String FROM_EMAIL = "csw3242@gmail.com";
    private static final String APP_PASSWORD = "vwjoehthqnitdlqp";

    public void sendTempPassword(String user_email, String tempPw) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");
        props.put("mail.smtp.starttls.required", "true");
        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

        Session session = Session.getInstance(props, new javax.mail.Authenticator() {
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(FROM_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(user_email));
            message.setSubject("[404 X CLUB] 임시 비밀번호 안내");
            message.setText("안녕하세요. 404 X CLUB입니다.\n\n" +
                           "임시 비밀번호: " + tempPw + "\n\n" +
                           "로그인 후 반드시 비밀번호를 변경해주세요.");
            Transport.send(message);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
 // =========================================================================
 // --- 관리자 메일 발송 추가 0429 ---
 // =========================================================================
 public void sendAdminMail(List<String> emailList, String subject, String htmlContent) {
     Properties props = new Properties();
     props.put("mail.smtp.auth", "true");
     props.put("mail.smtp.starttls.enable", "true");
     props.put("mail.smtp.host", "smtp.gmail.com");
     props.put("mail.smtp.port", "587");
     props.put("mail.smtp.starttls.required", "true");
     props.put("mail.smtp.ssl.protocols", "TLSv1.2");

     Session session = Session.getInstance(props, new javax.mail.Authenticator() {
         protected PasswordAuthentication getPasswordAuthentication() {
             return new PasswordAuthentication(FROM_EMAIL, APP_PASSWORD);
         }
     });

     try {
         for (String email : emailList) {
             Message message = new MimeMessage(session);
             message.setFrom(new InternetAddress(FROM_EMAIL));
             message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(email));
             message.setSubject(subject);
             message.setContent(htmlContent, "text/html; charset=UTF-8");
             Transport.send(message);
         }
     } catch (Exception e) {
         e.printStackTrace();
     }
  }
}

