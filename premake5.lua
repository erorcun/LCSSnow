workspace "LCSSnow"
	configurations { "Debug", "Release", "DebugVC", "ReleaseVC" }
	location "build"

	files { "LCSSnow/*.*" }
	
	includedirs { "LCSSnow" }

    pbcommands = { 
       "setlocal EnableDelayedExpansion",
       "set file=$(TargetPath)",
       "FOR %%i IN (\"%file%\") DO (",
       "set filename=%%~ni",
       "set fileextension=%%~xi",
       "set target=!path!!filename!!fileextension!",
       "if exist \"!target!\" copy /y \"!file!\" \"!target!\"",
       ")" }
    
    function setpaths (gamepath, exepath, scriptspath)
       scriptspath = scriptspath or ""
       if (gamepath) then
          cmdcopy = { "set \"path=" .. gamepath .. scriptspath .. "\"" }
          table.insert(cmdcopy, pbcommands)
          postbuildcommands (cmdcopy)
          debugdir (gamepath)
          if (exepath) then
             debugcommand (gamepath .. exepath)
             dir, file = exepath:match'(.*/)(.*)'
             debugdir (gamepath .. (dir or ""))
          end
       end
       --targetdir ("bin/%{prj.name}/" .. scriptspath)
    end

project "LCSSnow"
	kind "SharedLib"
	language "C++"
	targetname "LCSSnow"
	targetdir "bin/%{cfg.buildcfg}"
	targetextension ".asi"
	characterset ("MBCS")
	linkoptions "/SAFESEH:NO"

	filter "configurations:Debug"
		defines { "DEBUG" }
		staticruntime "on"
		symbols "On"
		setpaths("C:/Users/erorcun/Downloads/gta3/", "gta3.exe", "plugins/")

	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"
		staticruntime "on"
		setpaths("C:/Users/erorcun/Downloads/gta3/", "gta3.exe", "plugins/")
		
	filter "configurations:DebugVC"
		defines { "DEBUG" }
		staticruntime "on"
		symbols "On"
		setpaths("C:/Users/erorcun/Downloads/gta vc/", "gta_vc.exe", "plugins/")

	filter "configurations:ReleaseVC"
		defines { "NDEBUG" }
		optimize "On"
		staticruntime "on"
		setpaths("C:/Users/erorcun/Downloads/gta vc/", "gta_vc.exe", "plugins/")
		