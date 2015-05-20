
	class Framework_Init {
		file = "Core\Framework";
		class coreLoop {};
		class corePreInit { preInit = 1; };
		class corePostInit { postInit = 1; };
		class DebugLog {};
		class GetConfig {};
		class Players {};
	};

	#include "Functions\functionList.hpp"
	#include "Notes\functionList.hpp"
