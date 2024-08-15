package architectJsTest;

class ArchitectJsTest {
    public static function main() {
		var jsPromiseIO = new JsPromiseIO();
		var testService = new TestService( jsPromiseIO );
		testService.mySimpleScript();
	}
}