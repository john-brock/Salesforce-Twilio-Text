public class SendTextMessageController {

    private static String ACCOUNT_SID = 'PUT_ACCOUNT_SID_HERE';
    private static String ACCOUNT_TOKEN = 'PUT_ACCOUNT_TOKEN_HERE';
    private static String FROM_NUMBER = 'PUT_PHONE_NUMBER_HERE';

    public String toNumber{get;set;}
    public String fromNumber{get;set;}
    public String message{get;set;}
    
    public SmsMessage smsMessage{get;set;}
    
    public SendTextMessageController() { }
    
    public SendTextMessageController(String toNumber, String fromNumber, String message) {
        smsMessage = new SmsMessage(toNumber, fromNumber, message);
    }
    
    public void send() {
        smsMessage = new SmsMessage(toNumber, FROM_NUMBER, message);
        HttpResponse res = sendSmsMessages(smsMessage);
    }
    
    public HttpResponse sendSmsMessages(SmsMessage message) {
        final String sid = SendTextMessageController.ACCOUNT_SID;
        final String token = SendTextMessageController.ACCOUNT_TOKEN;
        final String endpoint = 'https://api.twilio.com/2010-04-01/Accounts/' + sid + '/SMS/Messages';
        
        String authHeader = 'Basic ' + EncodingUtil.base64Encode(Blob.valueOf(sid+':'+token));
        HttpRequest req = new HttpRequest();
        req.setMethod('POST');
        req.setHeader('Authorization', authHeader);
        req.setEndpoint(endpoint);
        req.setBody(message.formatForPostReq());
        Http http = new Http();
        try {
            HttpResponse res = http.send(req);
            return res;
        } catch(System.CalloutException e) {
            throw e;
        }
    }

    public class SmsMessage {
        protected String to;
        protected String message;
        protected String fromNumber;

        public SmsMessage(String to, String fromNumber, String message) {
            this.to = fixPhoneNumber(to);
            this.fromNumber = fixPhoneNumber(fromNumber);
            this.message = message;
        }
        
        public String formatForPostReq() {
            return 'From=' + this.fromNumber + '&To=' + this.to + '&Body=' + this.message;
        }

        private String fixPhoneNumber(String phone) {
            return phone.replaceAll('[^\\d]', '');
        }
    }
    
}
