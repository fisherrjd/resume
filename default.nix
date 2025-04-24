{ pkgs ? import
    (fetchTarball {
      name = "jpetrucciani-2025-04-24";
      url = "https://github.com/jpetrucciani/nix/archive/02d0af77790dcfadbd6be23d6025dd45d101987c.tar.gz";
      sha256 = "1wrqq6navs1j6xc9377ksj8hvmv803m0kcdsn6sg4g6nk4j8w17p";
    })
    { }
}:
let
  name = "resume";


  tools = with pkgs; {
    cli = [
      jfmt
      nixup
    ];
    bun = [ bun ];
    scripts = pkgs.lib.attrsets.attrValues scripts;
  };

  scripts = with pkgs; { };
  paths = pkgs.lib.flatten [ (builtins.attrValues tools) ];
  env = pkgs.buildEnv {
    inherit name paths; buildInputs = paths;
  };
in
(env.overrideAttrs (_: {
  inherit name;
  NIXUP = "0.0.9";
})) // { inherit scripts; }
