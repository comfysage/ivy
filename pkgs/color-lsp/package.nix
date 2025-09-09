{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage (finalAttrs: {
  pname = "color-lsp";
  version = "v0.1.4";

  src = fetchFromGitHub {
    owner = "huacnlee";
    repo = "color-lsp";
    tag = finalAttrs.version;
    hash = "sha256-rjMeypPjqisO8mw8aPbkhB2J8tIjdBUmsYYsBDazO0o=";
  };

  cargoHash = "sha256-fq/OUemYtalkSSxZYun7e1QqbeHU1+uX+AT5EX2Ut/g=";

  meta = {
    description = "document color language server";
    homepage = "https://github.com/huacnlee/color-lsp";
    license = lib.licenses.mit;
    maintainers = [ { name = "comfysage"; } ];
  };
})
