{
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/vdb";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "2G";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/efi";
                mountOptions = [
                  "defaults" "umask=0077"
                ];
              };
            };
            luks = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                settings = {
                  allowDiscards = true;
                  bypassWorkqueues = true;    
                };
                content = {
                  type = "btrfs";
                  extraArgs = [ "-f" ];
                  subvolumes = {
                    "/nixos/@" = {
                      mountpoint = "/";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/nixos/@home" = {
                      mountpoint = "/home";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/nixos/@nix" = {
                      mountpoint = "/nix";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/nixos/@swap" = {
                      mountpoint = "/swap";
                      swap.swapfile.size = "16G";
                    };
                    "/nixos/@steam" = {
                      mountpoint = "/steam";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/shared/@secureboot" = {
                      mountpoint = "/etc/secureboot";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/nixos/@videos" = {
                      mountpoint = "/videos";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                    "/nixos/@ssh" = {
                      mountpoint = "/home/brauni/.ssh";
                      mountOptions = [ "compress=zstd" "noatime" ];
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}