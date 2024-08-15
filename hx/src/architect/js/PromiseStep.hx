package architect.js;

import haxe.Exception;
import js.lib.Promise;
import architect.core.IStep;

class PromiseStep<T> implements IStep<T> {
    
    private var _promise: Promise<T>;

    public function new(v: Promise<T>) {
        this._promise = v;
    }

    public function flatMap<V2>(f:T -> IStep<V2>):IStep<V2> {
        return new PromiseStep(
            this._promise.then( val -> 
                (cast( f( val ), PromiseStep<Dynamic> )).getPromise())
        );
    }

    public function getPromise(): Promise<T> {
        return this._promise;
    }

    public function map<V2>(f:T -> V2):IStep<V2> {
        return new PromiseStep(
            this._promise.then( val -> f( val ))
        );
    }

    public function catchError(f:Exception -> T):IStep<T> {
        return new PromiseStep(
            this._promise.catchError(e -> 
                Promise.resolve(f(new Exception(e.toString()))))
        );
    }
}