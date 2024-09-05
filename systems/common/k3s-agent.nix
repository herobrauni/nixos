{ lib
, inputs
, outputs
, pkgs
, ...
}: {

  sops.secrets.k3s-token = { };
  sops.secrets.k3s-vpn-auth-file = { };

  services.k3s = {
    enable = true;
    tokenFile = "/run/secrets/k3s-token";
    role = "agent";
    serverAddr = "https://k3s-oci-arm-0:6443";
    extraFlags = ''
      --vpn-auth-file /run/secrets/k3s-vpn-auth-file
    '';
    package = pkgs.k3s.overrideAttrs (oldAttrs: {
      installPhase = lib.replaceStrings
        [ (lib.makeBinPath (oldAttrs.k3sRuntimeDeps)) ]
        [ (lib.makeBinPath (oldAttrs.k3sRuntimeDeps ++ [ pkgs.tailscale ])) ]
        oldAttrs.installPhase;
    });
  };
}
