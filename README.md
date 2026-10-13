# Pbx_simple — micro-PBX SIP Windows

Servidor SIP/UDP mínimo para interligar um interfone SIP (ramal 101) a um telefone SIP (ramal 102) **na mesma LAN**. Escrito em Go sem dependências externas, interface web, banco de dados ou Docker. Compila para um executável único Windows.

## Instalação

1. Compile com Go 1.22+: `GOOS=windows GOARCH=amd64 CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o Pbx_simple.exe .`. Ou utilize o binário da entrega da conversa.
2. Copie `config.example.json` para `config.json` e **altere as duas senhas**.
3. Teste com `Pbx_simple.exe -config config.json`.
4. Execute `install.ps1` no PowerShell como administrador para criar uma **tarefa agendada na inicialização do Windows**, executada sem sessão interativa. **Não é um serviço nativo do Windows**.
5. Configure os aparelhos para registrar no IP fixo do PC, porta UDP **5060**, usuários **101** e **102**, com senhas correspondentes. No botão do interfone programe chamada para **102**.
6. Para remover a tarefa e a regra do firewall execute `uninstall.ps1` como administrador.

## Funcionamento

- REGISTER com autenticação SIP Digest MD5.
- Encaminha SIP INVITE, ACK, BYE, CANCEL e respostas; OPTIONS recebe 200 OK.
- **RTP/áudio passa direto entre os dois aparelhos**, sem passar pelo PBX. Configure um codec comum (por exemplo PCMA/G.711 A-law).
- Registro e estado mantidos somente em memória. Após reiniciar, os aparelhos devem registrar novamente.

## Limites

Somente para **LAN confiável**, não exponha SIP/UDP 5060 à Internet. Não implementa TLS, SRTP, NAT traversal, RTP relay, vídeo validado, conferências, gravação nem compatibilidade com todos os terminais. A abertura da fechadura por DTMF **não foi testada**. Mantenha as portas RTP liberadas entre interfone e telefone. A autenticação MD5 é padrão legado de terminais SIP e não criptografa a comunicação. Restrinja a porta 5060 aos IPs dos terminais no firewall, proteja `config.json` por ACL NTFS e faça teste físico com seus modelos.

## Testes e memória

`go test ./...` valida parsing SIP, autenticação e encaminhamento INVITE/180 Ringing por sockets UDP. Binário Windows amd64 compilado com tamanho aproximado de **2,9 MB**; o consumo de memória em um Windows real ainda precisa ser medido. Este projeto não substitui um PABX completo.
