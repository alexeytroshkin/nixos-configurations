{
  lib,
  fetchurl,
  runCommand,
}:
let
  version = "4.2.1";
  release = "https://github.com/snezhig/obsidian-front-matter-title/releases/download/${version}";
in
runCommand "obsidian-front-matter-title-${version}"
  {
    main = fetchurl {
      url = "${release}/main.js";
      hash = "sha256-bovKqYHWR94r93igboIPYaWbxK43qzEFcHKYwHxaWs8=";
    };
    manifest = fetchurl {
      url = "${release}/manifest.json";
      hash = "sha256-LLAHtJioX93JuJ4Ki1XMvFP/ushE/RE4G+H6AyloGTg=";
    };
    passthru.manifestId = "obsidian-front-matter-title-plugin";
    meta = {
      description = "Display Obsidian note titles from frontmatter";
      homepage = "https://github.com/snezhig/obsidian-front-matter-title";
      license = lib.licenses.gpl3Only;
      platforms = lib.platforms.all;
    };
  }
  ''
    mkdir -p "$out"
    cp "$main" "$out/main.js"
    cp "$manifest" "$out/manifest.json"
  ''
