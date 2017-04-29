	-- we have a different shared lib depending on whether we're shared-runtime (launcher)
	-- or dll-runtime (rest of game)

	local function do_shared(libc)
		project(libc and "SharedLibc" or "Shared")
			targetname(libc and "shared_libc" or "shared")
			language "C++"
			kind "StaticLib"

			if libc then
				flags { "StaticRuntime" }
			end

			add_dependencies { 'vendor:fmtlib' }

			defines "COMPILING_SHARED"

			if libc then
				defines "COMPILING_SHARED_LIBC"
			end

			includedirs { "client/citicore" }
			
			files
			{
				"shared/**.cpp", "shared/**.h", "client/shared/**.cpp", "client/shared/**.h"
			}

			configuration "not windows"
				excludes { "**/Hooking.*" }
	end

	do_shared(false)
	do_shared(true)