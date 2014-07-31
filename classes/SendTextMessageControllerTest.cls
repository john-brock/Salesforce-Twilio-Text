@isTest
private class SendTextMessageControllerTest {
    private static String TO_NUM = '(555) 555-5555';
    private static String FROM_NUM = '(444) 555-5555';
    private static String BODY = 'Test Body';
    
    // TODO -- this test should be improved
    static testMethod void testSendSmsMessage() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGen());

        SendTextMessageController controller = new SendTextMessageController(TO_NUM, FROM_NUM, BODY);
        HttpResponse res = controller.sendSmsMessages(controller.smsMessage);
        System.assertEquals('text/xml', res.getHeader('Content-Type'));
        System.assertEquals(200, res.getStatusCode());
    }
    
    static testMethod void testSmsMessage() {
        SendTextMessageController.SmsMessage message = new SendTextMessageController.SmsMessage(TO_NUM, FROM_NUM, BODY);
        String postResult = message.formatForPostReq();
        
        system.assert(postResult.contains('To=' + TO_NUM.replaceAll('[^\\d]', '')), 'Did not contain the right To number');
        system.assert(postResult.contains('From=' + FROM_NUM.replaceAll('[^\\d]', '')), 'Did not contain the right From number');
        system.assert(postResult.contains('Body=' + BODY), 'Did not contain the right To number');
    }
}