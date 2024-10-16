{
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship.settings = {
    battery = {
      display = [
        {
          style = "bold red";
          threshold = 10;
        }
        {
          style = "bold yellow";
          threshold = 30;
        }
        {
          style = "bold green";
          threshold = 100;
        }
      ];
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      directory = {
        truncation_length = 5;
        truncate_to_repo = false;
        truncation_symbol = ".../";
      };
      character = {
        error_symbol = "[✗](bold red)";
        success_symbol = "[>](bold green)";
      };
      line_break = {
        disabled = false;
      };
      time = {
        disabled = true;
      };
      username = {
        show_always = true;
      };
    };
  };
  programs.zsh = {
    enable = true;
    autocd = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    historySubstringSearch.enable = true;
    antidote = {
      enable = true;
      plugins = [
        "zsh-users/zsh-syntax-highlighting"
        "zsh-users/zsh-autosuggestions"
        "zsh-users/zsh-history-substring-search"
        "zsh-users/zsh-completions"
        "ael-code/zsh-colored-man-pages"
      ];
    };
    oh-my-zsh = {
      enable = true;
      # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins
      plugins = [
        "git"
        "thefuck" # hit Esc twice after a failed command to get suggestions
        "bgnotify"
        "ansible"
        "pip"
        "kubectl"
        "terraform"
      ];
    };
    shellAliases = {
      f = "fuck"; # in case zsh plugin's #1 suggestion won't do
      sound = ''pactl set-card-profile alsa_card.pci-0000_04_00.6 HiFi\ \(Headphones,\ Mic1,\ Mic2\);pactl set-card-profile alsa_card.pci-0000_04_00.6 HiFi\ \(Mic1,\ Mic2,\ Speaker\)'';
      headphones = ''pactl set-card-profile alsa_card.pci-0000_04_00.6 HiFi\ \(Headphones,\ Mic1,\ Mic2\)'';
      speakers = ''pactl set-card-profile alsa_card.pci-0000_04_00.6 HiFi\ \(Mic1,\ Mic2,\ Speaker\)'';
      rdp_docker = "source /home/brauni/.scripts/windows_pwd && podman unshare --rootless-netns wlfreerdp /v:127.0.0.1 /dynamic-resolution /u:brauni /p:$PASSWORD";
    };

    initExtra = ''
      function gpush(){
          git add .
          if [ -n "$1" ]
          then
              git commit -m "$1"
          else
              git commit -m update
          fi
          git push
      }
      function windows(){ podman compose -f "/home/brauni/.config/winapps/compose.yaml" $@ }
    '';
  };
}
