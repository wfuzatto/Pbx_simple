# Pbx_simple

Micro-PBX SIP/UDP para Windows: registro de ramais com autenticação Digest MD5, encaminhamento de chamadas SIP e RTP direto entre terminais na mesma rede local.

Instalação: copie `config.example.json` para `config.json`, configure senhas fortes, execute `Pbx_simple.exe -config config.json`. Interfone ramal 101, telefone ramal 102, servidor no IP do PC e porta UDP 5060.

Uso restrito à LAN confiável. Não exponha SIP diretamente à Internet. Não inclui RTP proxy, TLS/SRTP, NAT traversal, nem compatibilidade garantida com todos os terminais.

O código-fonte e testes também estão disponíveis no pacote ZIP de entrega.