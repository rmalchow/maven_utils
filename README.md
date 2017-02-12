# maven_utils

jsut some useful snippets for automating maven builds ... mainly, this
can be used as a slightly more flexible replacement for the maven release
plugin (although, minus the "resume" things ... ) 

you can easily build script that take additional parameters (such as a
jenkins BUILD_NUMBER) instead of simply incrementing the version.

this can ALSO be used on branches if you have to maintain (and do
bugfixes on) several minor versions, like so:

	master

	branches/1.5.x
		release -> 1.5.0
			-> 1.5.1
			-> 1.5. ...
	branches/1.6.x
		release -> 1.6.0
			-> etc ...


