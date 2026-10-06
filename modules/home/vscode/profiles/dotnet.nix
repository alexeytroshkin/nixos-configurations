#----------------------------------------------------------------
# Модуль для разработки на C#.
# Предполагает, что в среде установлен .NET 10.
#----------------------------------------------------------------

{ pkgs, ... }:

{
  extensions = with pkgs.vscode-extensions; [
    ms-dotnettools.vscode-dotnet-runtime
    ms-dotnettools.csharp
    ms-dotnettools.csdevkit
  ];
  userSettings = {
    "dotnetAcquistionExtension.existingDotnetPath" = [
      {
        "extensionId" = "ms-dotnettools.csharp";
        "path" = "dotnet";
      }
      {
        "extensionId" = "ms-dotnettools.csdevkit";
        "path" = "dotnet";
      }
    ];
    # Restart the extensions when the flake changes.
    # Sometimes the csharp extensions get in first and errors are displayed.
    # One of them can be suppressed, the other unfortunately cannot be.
    # With this setting you can ignore the error, the extension will be
    # reloaded and the correct path used.
    # VSCode isn't planning on addressing extension startup ordering.
    # https://github.com/microsoft/vscode/issues/46846
    # "csharp.suppressDotnetInstallWarning" = true;
    # "direnv.restart.automatic" = true;
  };
}
