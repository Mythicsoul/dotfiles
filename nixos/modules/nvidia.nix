{
  config,
  pkgs,
  lib,
  pkgsUnstable,
  ...
}:
# nixpkgs.overlays = [
#   (self: super: {
#     nvidia-vaapi-driver-overlay = super.nvidia-vaapi-driver.overrideAttrs (old: {
#       version = "0.0.14";
#       src = super.fetchFromGitHub {
#         owner = "elFarto";
#         repo = "nvidia-vaapi-driver";
#         rev = "v0.0.14";
#         sha256 = "sha256-Nf2Qh+POkcKXjiHlmpfSCbY+vgT63bWIaMxQHHYtE04=";
#       };
#     });
#   })
# ];
#
# let
#   nvidiaBleedingEdge = pkgs.linuxPackages.nvidiaPackages.mkDriver {
#     version = "580.76.05";
#     sha256_64bit = "219be636b60931b021b2e8c1e0eff887363c731f8a940caa87bcc054d05d97fd";
#     sha256_aarch64 = "219be636b60931b021b2e8c1e0eff887363c731f8a940caa87bcc054d05d97fd";
#     openSha256 = "sha256-ll7HD7dVPHKUyp5+zvLeNqAb6hCpxfwuSyi+SAXapoQ=";
#     settingsSha256 = "sha256-ll7HD7dVPHKUyp5+zvLeNqAb6hCpxfwuSyi+SAXapoQ=";
#     persistencedSha256 = lib.fakeSha256;
#     };
#     # Override build inputs to add pkg-config and gtk3 for proper build

#     nvidiaOverlay = nvidiaBleedingEdge.overrideAttrs  (old: {
#       nativeBuildInputs = (old.nativeBuildInputs or []) ++ [ pkgs.pkg-config ];
#       buildInputs = (old.buildInputs or []) ++ [ pkgs.gtk3 ];
#     });

# in
{

  # nixpkgs.overlays = [
  #   (self: super: {
  #     nvidia-vaapi-driver = pkgsUnstable.nvidia-vaapi-driver;
  #   })
  # ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      # nvidia-vaapi-driver-overlay
      # pkgsUnstable.nvidia-vaapi-driver
      libva
      libva-utils
      nvidia-vaapi-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  # hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
  #   version = "580.76.05";
  #   sha256_64bit = "219be636b60931b021b2e8c1e0eff887363c731f8a940caa87bcc054d05d97fd";
  #   sha256_aarch64 = "219be636b60931b021b2e8c1e0eff887363c731f8a940caa87bcc054d05d97fd";
  #   openSha256 = "sha256-ll7HD7dVPHKUyp5+zvLeNqAb6hCpxfwuSyi+SAXapoQ=";
  #   settingsSha256 = "sha256-ll7HD7dVPHKUyp5+zvLeNqAb6hCpxfwuSyi+SAXapoQ=";
  #   persistencedSha256 = lib.fakeSha256;
  # };
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    powerManagement.enable = true; # possible fix for suspend issues hyprlock/-idle
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # package = nvidiaOverlay;
  };
}
