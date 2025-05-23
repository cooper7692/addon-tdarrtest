#!/usr/bin/env bash

cd /tdarr || exit 1
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Changed working directory to /tdarr"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Starting Tdarr Node Updater..."
./Tdarr_Updater

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Waiting for node to finish setup..."
sleep 10

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Creating dynamic Tdarr_Node_Config.json..."

cat <<EOF > /config/Tdarr_Node_Config.json
{
  "nodeName": "${NODENAME}",
  "serverURL": "http://${SERVERIP}:${SERVERPORT}",
  "serverIP": "${SERVERIP}",
  "serverPort": "${SERVERPORT}",
  "handbrakePath": "",
  "ffmpegPath": "",
  "mkvpropeditPath": "",
  "pathTranslators": [
    {
      "server": "",
      "node": ""
    }
  ],
  "nodeType": "mapped",
  "unmappedNodeCache": "/tdarr/unmappedNodeCache",
  "logLevel": "${LOGLEVEL}",
  "priority": -1,
  "cronPluginUpdate": "",
  "apiKey": "",
  "maxLogSizeMB": 10,
  "pollInterval": ${POLLINTERVAL},
  "startPaused": ${STARTPAUSED}
}
EOF

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Launching Tdarr Node..."
exec ./Tdarr_Node
echo "[$(date '+%Y-%m-%d %H:%M:%S')] Tdarr Node has exited."