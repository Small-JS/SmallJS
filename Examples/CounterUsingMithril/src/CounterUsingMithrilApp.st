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
		m: 'table#formTable.w5.center.tc.br3.ba.bw1.bg-white.b--gray.bs-16px.shadow-10px-grey' 
		with: (Mithril 
			m: 'tbody'
			with: (Mithril
				m: 'tr'
				with: (Mithril 
					m: 'td.f3.b.bg-light-blue.mt0.mb0'
					with: (Mithril 
						m: 'div.flex.items-center.justify-center'
						with: (Mithril 
							m: 'img#logoImage' 
							with: (Mithril
								attribute: 'src' value: 'logo.png'
								attribute: 'height' value: '40'
							)
						) 
						with: (Mithril 
							m: 'span#titleMessage' 
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
						m: 'span#counterSpan.b.black.garamond.f1'
						with: counter value toString
					) 
				)
			)
			with: (Mithril 
				m: 'tr'
				with: (Mithril 
					m: 'td'
					with: (Mithril 
						m: 'button#incrementButton.bg-light-green.br3.f3.w2' 
						with: (Mithril attribute: 'onclick' value: [self increment]) 
						with: '+'
					)
					with: (Mithril 
						m: 'span'
						with: (Mithril trust: '&nbsp;&nbsp;&nbsp;&nbsp;')
					)
					with: (Mithril 
						m: 'button#resetButton.bg-light-coral.br3.f3.w2'
						with: (Mithril attribute: 'onclick' value: [self reset]) 
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
