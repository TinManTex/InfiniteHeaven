-- initMock.lua

Script.LoadLibrary"/Assets/tpp/script/lib/InfInspect.lua"--tex
Script.LoadLibrary"/Assets/tpp/script/lib/InfUtil.lua"--tex
Script.LoadLibrary"/Assets/tpp/script/lib/InfCore.lua"--tex
Script.LoadLibrary"/Assets/tpp/script/lib/IvarProc.lua"--tex
--tex init seems to be loaded sandboxed, or some other funkery preventing _G from being added to, so loading some external modules to global inside InfInit (LoadLibrary is not boxed).
Script.LoadLibrary"/Assets/tpp/script/lib/InfInit.lua"--tex
print"parse: initMock done"