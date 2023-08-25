with import <nixpkgs> {};
mkShell {
  buildInputs = [
		lua-language-server
  ];
}
