# Ollama
- [Nixos Options](https://search.nixos.org/options?channel=24.11&query=ollama)
- [Ollama Models](https://ollama.com/search)

# Openwebui
- [Nixos options](https://search.nixos.org/options?channel=24.11&query=open-webui)
- https://docs.openwebui.com/

# Binary Cache for CUDA
- https://app.cachix.org/cache/cuda-maintainers
- https://discourse.nixos.org/t/cuda-cache-for-nix-community/56038

## Notes in German
# Deploy
1. RSA Key erstellen und public key zu den deploy keys eintragen:
    - `ssh-keygen -f ~/.ssh/id_github_deploy -t ed25519 -q -N ""`
2. Pub key anzeigen:
    - `cat ~/.ssh/id_github_deploy.pub`
3. Schlüssel im Project als Deploy key eintragen.
4. Repo clonen, in den Ordner wechseln und git konfigurieren:
    - `git clone  git@github.com:QFL-Lab/llm-chatbot.git --config core.sshCommand="ssh -i ~/.ssh/id_github_deploy" && cd nixos-configuration`
    - `git config pull.rebase false && git config --global user.name "Nikolas Longen" && git config --global user.email "nikolaslongen@gmail.com"`
5. Rebuild mit configuration.nix aus github repo: 
    - `sudo nixos-rebuild -I nixos-config=./hosts/$(newHostname)/configuration.nix switch`
    - Nach dem ersten aufrufen wird mit `base.nix` ein alias gesetzt, damit man sich das `-I ...`sparen kann
