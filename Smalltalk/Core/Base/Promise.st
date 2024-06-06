CLASS Promise EXTENDS JsObject MODULE Core CLASSVARS '' VARS ''

CLASSMETHODS

"Creation"

new: resolveRejectBlock
	^ Promise fromJs: INLINE
		'this.js = new Promise( ( resolve, reject ) => resolveRejectBlock.$value$value$(
			new StBlock().$js$( resolve ), new StBlock().$js$( reject ) ) )'.
!
resolve: object
	^ Promise fromJs: INLINE 'Promise.resolve( object )'.
!
reject: reason
	^ Promise fromJs: INLINE 'Promise.reject( reason )'.
!

"Testing collections"

all: promises then: block
	^ ( Promise fromJs: INLINE 'Promise.all( promises.$toJs() )' )
		then: [ :jsArray | block value: ( Array new js: jsArray ) ].
!
allSettled: promises then: block
	^ ( Promise fromJs: INLINE 'Promise.allSettled( promises.$toJs() )' )
		then: [ :jsArray | block value: ( Array fromJs: jsArray elementClass: PromiseStatus ) ].
!
any: promises then: block
	^ ( Promise fromJs: INLINE 'Promise.any( promises.$toJs() )' )
		then: [ :value | block value: value ].
!
race: promises then: block
	^ ( Promise fromJs: INLINE 'Promise.race( promises.$toJs() )' )
		then: [ :value | block value: value ].
!

METHODS

then: block
	INLINE 'this.js.then( ( result ) => block.$value$( result ) )'.
!
catch: block
	INLINE 'this.js.catch( ( error ) => block.$value$( error ) )'.
!
finally: block
	INLINE 'this.js.finally( () => block.$value() )'.
!
async awt
	^ INLINE 'await this.js'.
!
