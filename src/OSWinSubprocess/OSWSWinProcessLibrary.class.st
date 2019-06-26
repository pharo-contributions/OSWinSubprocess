"
PhLProcess can be used to run new processes on Windows.
It uses Windows MSVCRT dll.

https://docs.microsoft.com/en-us/windows/desktop/api/processthreadsapi/nf-processthreadsapi-createprocessa
"
Class {
	#name : #OSWSWinProcessLibrary,
	#superclass : #FFILibrary,
	#pools : [
		'OSWSWinTypes'
	],
	#category : #OSWinSubprocess
}

{ #category : #public }
OSWSWinProcessLibrary class >> clear: externalStructure [
	^ self memSet: externalStructure value: 0
]

{ #category : #private }
OSWSWinProcessLibrary class >> memSet: externalStructure value: value [
	^ self uniqueInstance
		memSet: externalStructure getHandle
		value: value
		size: externalStructure class structureSize
]

{ #category : #public }
OSWSWinProcessLibrary >> closeHandle: handle [
	^ self ffiCall: #(int CloseHandle(void * handle)) module: #Kernel32
]

{ #category : #public }
OSWSWinProcessLibrary >> createProcess: appName command: commandLine processAttributes: processAttributes threadAttributes: threadAttributes inheritHandles: inheritHandles creationFlags: creationFlags environment: environment directory: currentDirectory startup: startupInfo processInformation: processInformation [
	^ self ffiCall: 
#(Boolean CreateProcessW(
  LPCWSTR                appName,
  LPCWSTR                 commandLine,
  void* "LPSECURITY_ATTRIBUTES"  processAttributes,
  void* "LPSECURITY_ATTRIBUTES"  threadAttributes,
  Boolean                inheritHandles,
  DWORD                  creationFlags,
  LPVOID                 environment,
  LPCWSTR                currentDirectory,
  #OSWSStartupInfoW        *startupInfo,
  #OSWSProcessInformation *processInformation
)) module: #Kernel32
	
"
	#(int CreateProcessA (const char * appName, char * command, 0, 0, 0, ulong flags, 0, 0, ExternalAddress * startup, ExternalAddress * processInfo)) module: #Kernel32"
]

{ #category : #public }
OSWSWinProcessLibrary >> getLastError [
	^ self ffiCall: #(DWORD GetLastError(void)) module: #Kernel32
]

{ #category : #public }
OSWSWinProcessLibrary >> getProcess: hProcess exitCode: lpExitCode [
	^ self ffiCall: 
#(Boolean GetExitCodeProcess(
  HANDLE  hProcess,
  LPDWORD *lpExitCode
)) module: #Kernel32
]

{ #category : #public }
OSWSWinProcessLibrary >> memSet: ptr value: value size: size [
	^ self ffiCall: #(void* memset(void* ptr, int value, size_t size))
]

{ #category : #public }
OSWSWinProcessLibrary >> terminate:hProcess exitCode:uExitCode [
	^ self ffiCall: #(
Boolean TerminateProcess(
  HANDLE hProcess,
  uint   uExitCode
)) module: #Kernel32
]

{ #category : #public }
OSWSWinProcessLibrary >> waitForSingleObject: handle milliSeconds: ms [
	^ self ffiCall: #( uint WaitForSingleObject (void * handle, uint ms)) module: #Kernel32
]

{ #category : #public }
OSWSWinProcessLibrary >> win32ModuleName [
	^ 'msvcrt.dll'
]
