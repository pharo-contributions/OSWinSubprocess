Extension { #name : #String }

{ #category : #'*OSWinSubprocess' }
String >> surroundedByDoubleQuotes [
	"Answer the receiver with leading and trailing double quotes.  "

	^ self surroundedBy: ($" asString)
]
