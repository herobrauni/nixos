{ pkgs, ... }: {
  home.packages = with pkgs; [
    kubectl
    fluxcd
    k9s
    kubernetes-helm
    lens
    pv-migrate
    kompose
  ];
}
