{
  config,
  lib,
  pkgs,
  ...
}:
let
  vault = config.programs.obsidian.vaults.expansion;
  frontMatterTitle = pkgs.callPackage ../front-matter-title { };
  pluginPath = "plugins/${frontMatterTitle.manifestId}";
in
{
  programs.obsidian = {
    vaults = {
      expansion = {
        target = "Workspaces/expansion_/docs";
        settings = {
          corePlugins = [
            "backlink"
            "bases"
            "bookmarks"
            "canvas"
            "command-palette"
            "daily-notes"
            "editor-status"
            "file-explorer"
            "file-recovery"
            "global-search"
            "graph"
            "note-composer"
            "outgoing-link"
            "outline"
            "page-preview"
            "properties"
            "switcher"
            "sync"
            "tag-pane"
            "templates"
            "word-count"
            {
              name = "zk-prefixer";
              settings = {
                format = "YYYYMMDDHHmmss";
                folder = "";
                template = "templates/20261001182129";
              };
            }
          ];
          communityPlugins = [
            {
              pkg = frontMatterTitle;
              settings = builtins.fromJSON (builtins.readFile ../front-matter-title/settings.json);
            }
          ];
        };
      };
    };
  };

  # The Obsidian module generates home.file entries without a vault-level force option.
  # Allow the first activation to replace the existing local plugin files/settings.
  home.file = lib.mkIf (config.programs.obsidian.enable && vault.enable) (
    lib.genAttrs
      (map (path: "${vault.target}/.obsidian/${path}") [
        "core-plugins.json"
        "zk-prefixer.json"
        "community-plugins.json"
        pluginPath
        "${pluginPath}/data.json"
      ])
      (_: {
        force = true;
      })
  );
}
