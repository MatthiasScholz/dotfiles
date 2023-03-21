/* copy from nixpkgs but updated to fix arm64 support */
/* Source: https://github.com/mitchellh/nixos-config/blob/main/pkgs/1password.nix */
{ lib, stdenv, fetchzip, autoPatchelfHook, fetchurl, xar, cpio }:

stdenv.mkDerivation rec {
  pname = "1password";
  # latest: 2.15.0 (https://app-updates.agilebits.com/product_history/CLI2)
  version = "2.15.0";
  src =
    if stdenv.isLinux then
      fetchzip
        {
          url = {
            "x86_64-linux" = "https://cache.agilebits.com/dist/1P/op2/pkg/v${version}/op_linux_amd64_v${version}.zip";
            #"aarch64-linux" = "https://cache.agilebits.com/dist/1P/op2/pkg/v${version}/op_linux_arm64_v${version}.zip";
          }.${stdenv.hostPlatform.system};
          sha256 = {
            "x86_64-linux" = "43c07841c10f1f7af6b03b27edcdd569024697cc9fa79c508af6b2d081c37188";
            #"aarch64-linux" = "sha256-17cS/Sf+DPZDlUsDYrO37vI6zjkeDhWXWQ/wk1jSAYo=";
          }.${stdenv.hostPlatform.system};
          stripRoot = false;
        } else
      fetchurl {
        # MacOSX
        url = "https://cache.agilebits.com/dist/1P/op2/pkg/v${version}/op_apple_universal_v${version}.pkg";
        sha256 = "2895575b665ed4098358d79311fafb4ac64c0662f231f06ffc5802f9701db340";
      };

  buildInputs = lib.optionals stdenv.isDarwin [ xar cpio ];

  unpackPhase = lib.optionalString stdenv.isDarwin ''
    xar -xf $src
    zcat op.pkg/Payload | cpio -i
  '';

  installPhase = ''
    install -D op $out/bin/op
  '';

  dontStrip = stdenv.isDarwin;

  nativeBuildInputs = lib.optionals stdenv.isLinux [ autoPatchelfHook ];

  doInstallCheck = true;

  installCheckPhase = ''
    $out/bin/op --version
  '';

  meta = with lib; {
    description = "1Password command-line tool";
    homepage = "https://support.1password.com/command-line/";
    downloadPage = "https://app-updates.agilebits.com/product_history/CLI2";
    maintainers = with maintainers; [ joelburget marsam ];
    license = licenses.unfree;
    platforms = [ "x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin" ];
  };
}
