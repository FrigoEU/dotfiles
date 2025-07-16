# x1:
# 	sudo nixos-rebuild switch --flake .#nixos-x1

slim5:
	sudo nixos-rebuild switch --flake .#nixos-slim5 --show-trace

desktop:
	sudo nixos-rebuild switch --flake .#nixos-desktop 
