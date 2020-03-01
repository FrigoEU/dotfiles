# nix-store --add-fixed sha256 PragmataPro-Regular0.828.zip

{ runCommand, requireFile, unzip }:

  let
    versionMajor = "0";
    versionMinor = "828";
    name = "pragmata-pro-${versionMajor}${versionMinor}";
  in

    runCommand name
      rec {
        # outputHashMode = "recursive";
        # outputHashAlgo = "sha256";
        # outputHash = "0zh1zpinq8jw3h2mkqizrpcgnmy1nsi0idazfa57wly802ab9p5k";

        # this file needs to be in 
        src = requireFile rec {
          name = "PragmataPro-Regular${versionMajor}.${versionMinor}.zip";
          url = "file://path/to/${name}"; # dummy
          sha256 = "10k9p1r4qi02ybf8if79nh8r907pc8ymlkz0lwmjwdjrd01dw4xj";
        };

        buildInputs = [ unzip ];
      } ''
  unzip $src
  install_path=$out/share/fonts/truetype/pragmatapro
  mkdir -p $install_path
  find -name "PragmataPro*.ttf" -exec mv {} $install_path \;
''
