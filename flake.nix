{
  description = "NixOS Configuration";

  inputs = {
    # NixOS official package source, using the nixos-unstable branch here for a rolling release
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    # Please replace my-nixos with your hostname
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [
        # Import the previous configuration.nix we used,
        # so the old configuration file still takes effect
        ./configuration.nix
        ./fonts.nix
        # ./gpu.nix  # Adding Nvidia support and Intel GPU stuff
        ./swap.nix  # Adding swap file
        # ./tlp.nix  # Adding TLP for better battery use
        # Home manager as a module of nixos
        # So home-manager configurations are deployed with nixos-rebuild switch
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.users.jay = import ./home;
        }
      ];
    };
  };
}
