{ lib
, inputs
, outputs
, pkgs
, ...
}: {

  services.k3s = {
    enable = true;
    tokenFile = "/run/secrets/k3s-token";
    role = "agent";
    serverAddr = "https://k3s-oci-arm-0:6443";
    extraFlags = ''
      --vpn-auth-file /run/secrets/k3s-vpn-auth-file
    '';
  };
}
