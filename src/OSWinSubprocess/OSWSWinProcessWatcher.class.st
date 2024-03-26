"
This class is in charge of watching the execution of the process given as input to check regularly if it is still running or not.
When the process is completed, I do a callback on the process so that it cleans the process fields.
"
Class {
	#name : #OSWSWinProcessWatcher,
	#superclass : #Object,
	#instVars : [
		'watchProcess',
		'process'
	],
	#pools : [
		'OSWSWinTypes'
	],
	#category : #OSWinSubprocess
}

{ #category : #'instance creation' }
OSWSWinProcessWatcher class >> on: aProcess [
	^ self new 
		process: aProcess
]

{ #category : #accessing }
OSWSWinProcessWatcher >> process: aProcess [
	process := aProcess
]

{ #category : #watching }
OSWSWinProcessWatcher >> watch [
	"active loop to catch the end of the process"

	watchProcess := [ [ process isRunning ]
		whileTrue: [ 200 milliSeconds wait ].
		process completionCallback ]
		forkAt: 35
		named: 'WinProcess watcher'
]
