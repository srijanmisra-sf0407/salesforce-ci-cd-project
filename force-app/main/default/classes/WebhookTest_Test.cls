@isTest
private class WebhookTest_Test {
    @isTest
    static void testGetGreeting() {
        // Prepare for the test
        Test.startTest();

        // Call the method from the class being tested
        String greeting = WebhookTest.getGreeting();

        // Stop the test context
        Test.stopTest();

        // Verify that the method returned the correct message
        System.assertEquals('Hello from the feature branch!', greeting, 'The greeting message was not correct.');
    }
}