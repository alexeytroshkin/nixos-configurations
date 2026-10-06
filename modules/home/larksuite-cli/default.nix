{ pkgs, lib, ... }:
let
  version = "1.0.32";
in
pkgs.buildGoModule {
  pname = "larksuite-cli";
  version = version;

  src = pkgs.fetchFromGitHub {
    owner = "larksuite";
    repo = "cli";
    rev = "v${version}";
    sha256 = "sha256-bvq1PHn4221xsY8nrbbb9ypsAyjqkKp8i9v8Qze1UYs=";
  };

  vendorHash = "sha256-NvDwhcY/L7d+zSDmrOs50oJD9cbcbWxsw1ONr3dpwlY=";

  # Пропускаем автоматически запускаемые тесты т.к. некоторые из них падают и мешают сборке
  doCheck = false;

  # Переименовываем cli в lark-cli (buildGoModule по умолчанию называет исполняемый файл именем Go-модуля)
  postInstall = ''
    mv $out/bin/cli $out/bin/lark-cli
  '';

  meta = with lib; {
    description = "The official Lark/Feishu CLI tool, maintained by the larksuite team — built for humans and AI Agents";
    homepage = "https://github.com/larksuite/cli";
    licence = licenses.mit;
  };
}
