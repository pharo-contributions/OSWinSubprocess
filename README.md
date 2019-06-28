# OSWinSubprocess [![Build status](https://ci.appveyor.com/api/projects/status/25lrvnst0ik4b0td?svg=true)](https://ci.appveyor.com/project/demarey/oswinsubprocess)

OSSubprocess is a project that allows the user to spawn Windows System processes from within Pharo language. The main usage of forking external OS processes is to execute OS commands (.e.g dir, copy, etc) as well as arbitrary commands (.e.g C:\Users\me\myscript.bat or pharo.exe) from Pharo. This library uses the [Windows API](https://docs.microsoft.com/en-us/windows/desktop/api/processthreadsapi/nf-processthreadsapi-createprocessw) to create process from both 32-bit and 64-bit Pharo images. It also supports Unicode characters.

OSWinSubprocess name is really closed to the name of the [OSSubprocess projet](https://github.com/pharo-contributions/OSSubprocess) that allows to spawn external Unix or OS X processes. OSWinSubprocess and OSSubprocess are complementary and share a part of the API. A mid-term goal would be to unify these projects under the same umbrella.

Important note: As of now, this library does not yet support standard streams (stdin, stdout and stderr). It could be done by setting the appropriate information in the [STARTUPINFO structutre](https://docs.microsoft.com/fr-fr/windows/desktop/api/processthreadsapi/ns-processthreadsapi-_startupinfoa).

## Installation
**Currently, OSWinSubprocess has only be tested on Pharo 7.0**.
From within Pharo, execute the following to install OSWinSubprocess:

```Smalltalk
Metacello new
 	baseline: 'OSWinSubprocess';
 	repository: 'github://pharo-contributions/OSWinSubprocess:master/repository';
	load.
```
## Getting Started
OSWinSubprocess is quite easy to use but depending on the user needs, there are different parts of the API that could be used. We start with a basic example and later we show more complicated scenarios.

```Smalltalk
OSWSWinProcess new 
		shellCommand: 'echo'
		arguments: #('ok');
		runAndWait.
```

A subprocess consist of at least a command/binary/program to be executed (in this example `echo`) plus some optional array of arguments.

## Configuration
```Smalltalk
OSWSWinProcess new 
		command: 'echo';
		workingDirectory: 'C:/';
		arguments: #('ok');
		runAndWait.
```

OsWinSubprocess offers some facilities to run a command line within a shell:
* `shellCommand:` runs a Windows cmd.exe shell with the provided command, i.e. a string with the command name and arguments. 
* `shellCommand:arguments:` runs a Windows cmd.exe shell with the provided command and a collection of arguments.
Warning: Paths with spaces need to be surrounded by double quotes.

## API
OSWSWinProcess instances gives you an high-level API to run and possibly wait for the process termination. It also allows you to get back some information on the process.
* `runAndWait` Runs the process AND waits until the child has exited. Warning: this method freezes the image until the forked process exits.
* `runAndWaitTimeOut: nbMilliSeconds`Runs the process AND waits until the child has exited.
* `runUnwatch` Used to run a process and forget about it
* `run` Runs the process and watch it
* `terminate` Terminates (kill) the process. Will set a non-success exit code (3).
* `isRunning` Answers true if the process is still running, else false.
* `isComplete` Answers true if the process is not running and exitCode is set, else false.
* `isSuccess` Answers true if the process is not running and exitCode is 0 and no error happened, else false.
* `hasTimedOut` Answers true if the process did not terminate before the given timeout, else false.
* `exitCode` Returns the process exit code if set, else nil
* `lastError` Gives you the last error code value. See [Windows API documentation](https://docs.microsoft.com/en-us/windows/desktop/api/errhandlingapi/nf-errhandlingapi-getlasterror) for more information

## Known limitations
* no management of standard streams (stdin, stdout and stderr)
* one process watcher per process instance (could have only one process watcher for all processes)

## Authors
* **Keldon Alleyne** - *Initial binding to the Windows API through FFI* - [Keldon Alleyne](https://github.com/avasopht)
* **Christophe Demarey** - *Initial work* - [Christophe Demarey](https://github.com/demarey)

See also the list of [contributors](https://github.com/pharo-contributions/OSWinSubprocess/contributors) who participated in this project.

## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments
* OSWinSubprocess took inspiration from the [ProcessWrapper](http://smalltalkhub.com/mc/hernan/ProcessWrapper/main/) project ([source code](http://leves.web.elte.hu/ProcessWrapper)).
