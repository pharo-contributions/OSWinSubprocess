Class {
	#name : 'BaselineOfOSWinSubprocess',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfOSWinSubprocess',
	#package : 'BaselineOfOSWinSubprocess'
}

{ #category : 'baselines' }
BaselineOfOSWinSubprocess >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ 	spec
				package: #OSWinSubprocess;
				package: #'OSWinSubprocess-Tests' with: [ spec requires: #OSWinSubprocess ] ].
]
