### Running a Mongodb Replica Set using Docker
To set up a mongodb replica set using Docker, follow these steps:

- Ensure you have Docker installed on your machine. You can download and install Docker from the official website [here](https://www.docker.com/products/docker-desktop).
- Pull the mongoDB image from Docker Hub:
```bash
docker pull mongodb/mongodb-community-server:latest
```
- Run the image as a container:
```bash
docker run --name mongodb -p 27017:27017 -d mongodb/mongodb-community-server:latest --replSet my-rs
```
This command will start a mongoDB container with the name `mongodb` and expose port `27017` to the host machine.
- Install the mongo shell to connect to the mongoDB container. You can install the mongo shell by following the instructions [here](https://www.mongodb.com/docs/mongodb-shell/install/).
- Connect to the MongoDB Deployment with mongosh
```bash
mongosh --port 27017
```
- **First time only**: The first time you start the mongodb, do the following two quick steps
    - Run the command `mongosh` in another terminal to open the mongo shell.
    - In the mongo shell, run the following command to initiate the replica set:
    ```bash
    rs.initiate({_id: "my-rs", members: [{_id: 0, host: "localhost"}]})
    ```
    This command will initiate the replica set with the default configuration. You can customize the configuration as needed.
    - Run `Exit` to exit the mongo shell.

Additional setup instructions can be found [here](https://docs.mongodb.com/manual/tutorial/deploy-replica-set/).