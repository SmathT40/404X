package dto;

import lombok.Data;

@Data
public class Pay {

    private int pay_no;

    private String pay_uid;

    private String pay_date;

    private int pay_amount;

    private String pay_method;

    private String user_id;

    private int pay_status;

    private String pay_goods;
    
    private String order_id;
    
    /*
     * 주문번호 생성: 날짜(6자리) + 밀리초(3자리) + 랜덤(2자리)
     * 예: 260429 + 123 + AB = 260429123AB
     */
    public static String generateOrderId() {
        // 오늘 날짜 (yyMMdd)
        String datePart = java.time.format.DateTimeFormatter.ofPattern("yyMMdd")
                          .format(java.time.LocalDateTime.now());
        
        //현재 밀리초 (000~999)
        String milliPart = String.format("%03d", System.currentTimeMillis() % 1000);
        
        // 랜덤 2자리 (영문대문자)
        String chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        java.util.Random random = new java.util.Random();
        String randomPart = "" + chars.charAt(random.nextInt(chars.length())) 
                               + chars.charAt(random.nextInt(chars.length()));
        
        return datePart + milliPart + randomPart;
    }
}