####Installation and running:
```bash
mvn clean install
```
and then
```bash
java -jar target/chaos-agent-0.1-SNAPSHOT.jar
```

####Commands
terminate server:
```
curl -v -X POST http://localhost:10800/chaos/terminate/key-manager
```

startup server:
```
curl -v -X POST http://localhost:10800/chaos/revive/key-manager
```