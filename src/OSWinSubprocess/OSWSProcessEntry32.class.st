Class {
	#name : #OSWSProcessEntry32,
	#superclass : #FFIExternalStructure,
	#pools : [
		'OSWSWinTypes'
	],
	#category : #OSWinSubprocess
}

{ #category : #'field definition' }
OSWSProcessEntry32 class >> fieldsDesc [
	"self rebuildFieldAccessors"
	
	^ #(
	DWORD dwSize;
	DWORD cntUsage;
   DWORD th32ProcessID;
	void* th32DefaultHeapID;
	DWORD th32ModuleID;
	DWORD cntThreads;
	DWORD th32ParentProcessID;
	LONG pcPriClassBase;
	DWORD dwFlags;
   void* szExeFile;
	)
]
