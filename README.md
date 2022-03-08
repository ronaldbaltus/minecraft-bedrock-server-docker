# Minecraft bedrock server
This is docker image will run a minecraft bedrock server.
You can use the environment variables to modify options in the `server.properties`, or you can mount a volume that contains the `server.properties` and (if needed) `whitelist.json` and `permissions.json`. 

The available environment variables are:
- `MC_NAME` Name of the server (default: DockerMinecraftServer)
- `MC_GAMEMODE` Gamemode (default: survival)
- `MC_DIFFICULTY` Difficulty (default: easy)
- `MC_ALLOWCHEATS` Allow cheats (default: false)
- `MC_MAXPLAYERS` Maximum players (default: 10)
- `MC_ONLINEMODE` Online mode (default: true)
- `MC_WHITELIST` Whether to use a whitelist. (default: false)
- `MC_PORT` The port to run on (default: 19132)
- `MC_PORTV6` The port for ipv6 (default: 19133)
- `MC_VIEWDISTANCE` View distance (default: 32)
- `MC_TICKDISTANCE` The tick distance (default: 4)
- `MC_PLAYERIDLETIMEOUT` How much idle time till a player is kicked. (default: 30)
- `MC_MAXTHREADS` Maximum CPU threads to use (default: 8)
- `MC_LEVELNAME` Name of the world (default: level)
- `MC_LEVELSEED` Seed of the world (default: <empty>)

Example run:

`docker run --rm -it -e MC_NAME=my-server-name -p 19132:19132 ronaldbaltus/minecraft-bedrock-server:1.16.221.01`