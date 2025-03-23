CLASS CounterUsingMithrilApp EXTENDS BrowserApp MODULE CounterUsingMithrilApp CLASSVARS ''
	VARS 'counter'

start
	counter := Counter new.

	Mithril mountViewBlock: [ self buildUI ] .

	self testMode ifTrue: [
		TestCounterUsingMithrilApp new test: self ].
!

buildUI
	^ Mithril
		m: 'table' 
		with: (Mithril attribute: 'id' value: 'formTable')
		with: (Mithril 
			m: 'tbody'
			with: (Mithril
				m: 'tr'
				with: (Mithril 
					m: 'td.title'
					with: (Mithril 
						m: 'div.vertical-center'
						with: (Mithril 
							m: 'img' 
							with: (Mithril
								attribute: 'id' value: 'logoImage'
								attribute: 'src' value: 'logo.png'
								attribute: 'height' value: '40'
							)
						) 
						with: (Mithril 
							m: 'span' 
							with: (Mithril attribute: 'id' value: 'titleMessage')
							with: (Mithril trust: '&nbsp;&nbsp;Counter')
						)
					)
				)
			)
			with: (Mithril 
				m: 'tr'
				with: (Mithril 
					m: 'td' 
					with: (Mithril 
						m: 'span' 
						with: (Mithril attribute: 'id' value: 'counterSpan')
						with: counter value toString
					) 
				)
			)
			with: (Mithril 
				m: 'tr'
				with: (Mithril 
					m: 'td'
					with: (Mithril 
						m: 'button' 
						with: (Mithril 
							attribute: 'id' value: 'incrementButton' 
							attribute: 'onclick' value: [self increment]
						) 
						with: '+'
					)
					with: (Mithril 
						m: 'span'
						with: (Mithril trust: '&nbsp;&nbsp;&nbsp;&nbsp;')
					)
					with: (Mithril 
						m: 'button'
						with: (Mithril 
							attribute: 'id' value: 'resetButton' 
							attribute: 'onclick' value: [self reset]
						) 
						with: '0'
					)
				)
			)
		)
!

increment
	"Increase the counter"

	counter increment.
!

reset
	"reset the counter."

	counter reset.
!

"Accessing (used by tests)"

counterSpan
	^ Document getElementById: 'counterSpan' class: HtmlSpanElement.
!

incrementButton
	^ Document getElementById: 'incrementButton' class: HtmlButtonElement.
!

resetButton
	^ Document getElementById: 'resetButton' class: HtmlButtonElement.
!
