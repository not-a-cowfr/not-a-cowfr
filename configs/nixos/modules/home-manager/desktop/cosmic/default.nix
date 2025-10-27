{ inputs, ... }:
{
	imports = [
	    inputs.cosmic-manager.homeManagerModules.cosmic-manager
	];

	programs.cosmic-manager = {
		enable = true;
	};
}
