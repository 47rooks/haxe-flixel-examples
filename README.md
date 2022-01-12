# HaxeFlixel Examples

This repo contains a variety of examples based on whatever functionality I was
trying to understand at the time. Each top level directory is, for the most part,
a project created with `flixel tpl`. The code is documented as much as I felt 
necessary to clarify points in APIs and behaviour.

There is VSCode configuration for each of the examples. It is expected that you will
have Haxe, HaxeFlixel, flixel-addons and flixel-ui installed.

If you want to run on the Hashlink VM you will need that installed.

If you want to build binaries with the Hashlink library you will of course need that also.
Note, that I found that Hashlink should not be installed in a path with any spaces in directory
names. Ultimately this will break build, usually to binaries where the Hashlink libs have
to be added to the MSVC link line inside a VSCode task.