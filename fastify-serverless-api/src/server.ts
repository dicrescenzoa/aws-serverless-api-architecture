import 'dotenv/config'
import fastify from 'fastify'
import routes from "./routes";

const server = fastify()

const {ADDRESS = 'localhost', PORT = '3000', BASE_API_PATH = ''} = process.env;

server.register(routes, {prefix: BASE_API_PATH})

server.listen({host: ADDRESS, port: parseInt(PORT, 10)}, (err, address) => {
    if (err) {
        console.error(err)
        process.exit(1)
    }
    console.log(`Server listening at ${address}`)
})