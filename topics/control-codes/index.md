---
aliases: escape-sequences, ecma-48, iso-6429
created_by: Ecma International
display_name: terminal escape sequences
released: September 1976
short_description: terminal escape sequences is a standardized feature for controlling text formatting in terminals.
topic: control-codes
related: cli
wikipedia_url: https://en.wikipedia.org/wiki/ANSI_escape_code
---
Terminal escape sequences is a terminal feature, enabling CLI programs to output formatted text into the terminal. The feature is used extensively for making pseudographical command line interfaces, colouring logs output into stdout/stderr and syntax highlighting. Though standardized as [`ECMA-48`](https://www.ecma-international.org/publications/standards/Ecma-048.htm) and `ISO/IEC JTC 1/SC 2`, different terminals support different subsets of control codes, and there is some effort to invent more control codes for developers' needs.

Most of free open source terminals have this feature. Windows 10 [has built-in support of it with some extensions](https://docs.microsoft.com/en-us/windows/console/console-virtual-terminal-sequences). Older version of Windows users can use  [ansicon](https://github.com/adoxa/ansicon), [ConEmu](https://github.com/Maximus5/ConEmu), or  [MinTTY](https://github.com/mintty/mintty).
