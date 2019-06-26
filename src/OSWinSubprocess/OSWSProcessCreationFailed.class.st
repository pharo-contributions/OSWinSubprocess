"
Error thrown when the creation of a sub process fails.
"
Class {
	#name : #OSWSProcessCreationFailed,
	#superclass : #Error,
	#category : #OSWinSubprocess
}

{ #category : #accessing }
OSWSProcessCreationFailed >> description [
	^ 'Failed to create a new process'
]
