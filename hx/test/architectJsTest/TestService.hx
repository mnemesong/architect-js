package architectJsTest;

import architect.core.IStep;
import architect.core.IStepManager;

using Lambda;

interface ITestIO extends IStepManager {
	public function readLnInt() : IStep<Int>;

	public function printLnInt( i : Int ) : IStep<Dynamic>;
}

class TestService {
    private var io : ITestIO;

	public function new(
		io : ITestIO
	) {
		this.io = io;
	}

	public function mySimpleScript() : IStep<{}> {
		return this.io.all( [
			this.io.readLnInt(),
			this.io.readLnInt()
		] )
			.map( iii -> iii.map( i -> i + 10 ) )
			.map( iii -> {
				iii.iter( i -> this.io.printLnInt( i ) );
				return {};
			} );
	}
}