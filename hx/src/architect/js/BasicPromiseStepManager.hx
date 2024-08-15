package architect.js;

import architect.core.IStep;
import js.lib.Promise;
import architect.core.IStepManager;

class BasicPromiseStepManager implements IStepManager {

    public function new() {}

    /**
		Converts unit to Thenable
	**/
    public function lift<V>(v:V):IStep<V> {
        return new PromiseStep(Promise.resolve(v));
    }

    /**
		Await ready and success of all thenables and convert them values to array of
		same count, as a given array. 
	**/
    public function all<V>(all:Array<IStep<V>>):IStep<Array<V>> {
        var vals = all.map( v -> cast( v, PromiseStep<Dynamic> ).getPromise() );
		return cast new PromiseStep( Promise.all( vals ) );
    }

    /**
		Await ready of first success thenable and return its value as a thenable.
	**/
    public function any<V>(all:Array<IStep<V>>):IStep<V> {
        var vals = all.map( v -> cast( v, PromiseStep<Dynamic> ).getPromise() );
		return cast new PromiseStep( Promise.race( vals ) );
    }

    /**
		Executes procedure and lift result to Thenable context
	**/
	public function exec<A>( f : () -> A ) : IStep<A> {
		try {
			var result = f();
			return new PromiseStep( Promise.resolve( result ) );
		} catch( e ) {
			return new PromiseStep( Promise.reject( e ) );
		}
	}
}