{
  lib,
  buildGoModule,
  fetchFromGitHub,
  testers,
  bearer,
}:

buildGoModule rec {
  pname = "bearer";
  version = "1.48.0";

  src = fetchFromGitHub {
    owner = "bearer";
    repo = "bearer";
    tag = "v${version}";
    hash = "sha256-M9Usz+qQH4QNA/0TgtvjuqwnaCpyxr9OMIc8pJ/FjDE=";
  };

  vendorHash = "sha256-A0zy5O2+afhn6jAfLd/k7wvL3z1PVI0e6bO39cnYrhM=";

  subPackages = [ "cmd/bearer" ];

  ldflags = [
    "-s"
    "-w"
    "-X=github.com/bearer/bearer/cmd/bearer/build.Version=${version}"
  ];

  passthru.tests = {
    version = testers.testVersion {
      package = bearer;
      command = "bearer version";
    };
  };

  meta = with lib; {
    description = "Code security scanning tool (SAST) to discover, filter and prioritize security and privacy risks";
    homepage = "https://github.com/bearer/bearer";
    changelog = "https://github.com/Bearer/bearer/releases/tag/v${version}";
    license = with licenses; [ elastic20 ];
    maintainers = with maintainers; [ fab ];
  };
}
