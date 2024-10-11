{
  description = "brauni NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix.url = "github:Mic92/sops-nix";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , systems
    , lix-module
    , ...
    } @ inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      forEachSystem = f: lib.genAttrs (import systems) (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs (import systems) (
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        }
      );
    in
    {
      inherit lib;

      # devShells = forEachSystem (pkgs: import ./shell.nix {inherit pkgs;});
      formatter = forEachSystem (pkgs: pkgs.alejandra);

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # envy
        envy = nixpkgs.lib.nixosSystem {
          modules = [
            ./systems/envy
            lix-module.nixosModules.default
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
        # desk
        desk = nixpkgs.lib.nixosSystem {
          modules = [
            ./systems/desk
            lix-module.nixosModules.default
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
        # k3s-oci-arm
        k3s-oci-arm-2 = nixpkgs.lib.nixosSystem {
          modules = [
            ./systems/k3s-oci-arm-2
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
        k3s-oci-arm-3 = nixpkgs.lib.nixosSystem {
          modules = [
            ./systems/k3s-oci-arm-3
          ];
          specialArgs = {
            inherit inputs outputs;
          };
        };
      };


      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # envy laptop
        "brauni@envy" = lib.homeManagerConfiguration {
          modules = [
            ./home/envy.nix
            ./home/home.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
        # desk
        "brauni@desk" = lib.homeManagerConfiguration {
          modules = [
            ./home/desk.nix
            ./home/home.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
        # cachy
        "brauni@cachy" = lib.homeManagerConfiguration {
          modules = [
            ./home/cachy.nix
            ./home/home.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
        };
      };
    };
}
