package architectJsTest;

import architect.js.BasicPromiseStepManager;
import architect.core.IStep;
import architectJsTest.TestService.ITestIO;

using Lambda;

class JsPromiseIO implements ITestIO {

    var stepManager: BasicPromiseStepManager;
	public function new() {
        this.stepManager = new BasicPromiseStepManager();
    }

	/**
		Converts unit to Thenable
	**/
	public function lift<V>( v : V ) : IStep<V> {
		return this.stepManager.lift( v );
	}

	/**
		Await ready and success of all thenables and convert them values to array of
		same count, as a given array. 
	**/
	public function all<V>( all : Array<IStep<V>> ) : IStep<Array<V>> {
		return this.stepManager.all( all );
	}

	/**
		Await ready of first success thenable and return its value as a thenable.
	**/
	public function any<V>( all : Array<IStep<V>> ) : IStep<V> {
		return this.stepManager.any( all );
	}

	public function readLnInt() : IStep<Int> {
		return this.stepManager.exec(() -> {
			Sys.println( "Please input integer number:" );
			return Std.parseInt( Sys.stdin().readLine() );
		} );
	}

	public function printLnInt( i : Int ) : IStep<Dynamic> {
		return this.stepManager.exec(() -> {
			Sys.println( "Output num: " + Std.string( i ) );
			return false;
		} );
	}
}