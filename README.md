# Firefox via RDP

Firefox via RDP container basato su Ubuntu 20.04

## Caratteristiche

- Accesso remoto a Firefox tramite protocollo RDP (porta 3389)
- Configurazione dell'URL iniziale tramite variabile d'ambiente
- Possibilità di attivare/disattivare la modalità kiosk
- Scalabilità per display HiDPI

## Utilizzo

### Costruire il container
```
docker build -t firefox-rdp .
```

### Avviare il container con impostazioni predefinite

```
docker run -d -p 3389:3389 --name firefox firefox-rdp
```

### Avviare il container con configurazioni personalizzate

```
docker run -d \
  -p 3389:3389 \
  -e KIOSK_MODE=false \
  -e START_URL="https://www.google.com" \
  -e SCALE=1 \
  -e RESOLUTION="1920x1080x24" \
  --name firefox firefox-rdp
```

## Variabili d'ambiente disponibili

| Variabile | Descrizione | Valore predefinito |
|-----------|-------------|-------------------|
| KIOSK_MODE | Attiva/disattiva la modalità a schermo intero | true |
| START_URL | URL iniziale da caricare all'avvio | about:blank |
| SCALE | Fattore di scala per i display HiDPI | 1 |
| RESOLUTION | Risoluzione dello schermo virtuale | 1366x768x24 |

## Connessione

Utilizza un client RDP come Remmina, Microsoft Remote Desktop o mstsc.exe per connetterti al container:

- Indirizzo: `localhost` (o l'indirizzo IP del server Docker)
- Porta: `3389`
- Username: `user`
- Password: `user`

## Sicurezza

Per ambienti di produzione, considera di:
- Modificare la password utente predefinita
- Utilizzare un proxy HTTPS per accesso esterno sicuro
- Limitare l'accesso alla rete del container