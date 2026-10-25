CLASS Promise EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

"Creation"

fromJs: jsPromise then: then
	^ ( self fromJs: jsPromise )
		then: then.
!
fromJs: jsPromise then: block catch: catch
	"Chained, so catch also handles rejections of the promise returned by then:."
	^ ( ( self fromJs: jsPromise )
		then: block )
		catch: catch.
!
fromJs: jsPromise then: block catch: catch finally: finally
	^ ( ( ( self fromJs: jsPromise )
		then: block )
		catch: catch )
		finally: finally.
!
new: resolveRejectBlock
	^ self fromJs: INLINE
		'new Promise( ( resolve, reject ) => resolveRejectBlock.$value$value$(
			new StBlock().$js$( resolve ), new StBlock().$js$( reject ) ) )'.
!
resolve: object
	^ self fromJs: INLINE 'Promise.resolve( object )'.
!
reject: reason
	^ self fromJs: INLINE 'Promise.reject( reason )'.
!

"Testing collections"

all: promises then: block
	^ ( self fromJs: INLINE 'Promise.all( promises.$toJs() )' )
		then: [ :jsArray | block value: ( Array new js: jsArray ) ].
!
allSettled: promises then: block
	^ ( self fromJs: INLINE 'Promise.allSettled( promises.$toJs() )' )
		then: [ :jsArray | block value: ( Array fromJs: jsArray elementClass: PromiseStatus ) ].
!
any: promises then: block
	^ ( self fromJs: INLINE 'Promise.any( promises.$toJs() )' )
		then: [ :value | block value: value ].
!
race: promises then: block
	^ ( self fromJs: INLINE 'Promise.race( promises.$toJs() )' )
		then: [ :value | block value: value ].
!

METHODS

"Each method answers a new Promise, like its JS counterpart, so calls can be chained."

then: block
	^ Promise fromJs: INLINE 'this.js.then( ( result ) => block.$value$( result ) )'.
!
catch: block
	^ Promise fromJs: INLINE 'this.js.catch( ( error ) => block.$value$( stError$class.$fromJs$( error ) ) )'.
!
finally: block
	^ Promise fromJs: INLINE 'this.js.finally( () => block.$value() )'.
!
