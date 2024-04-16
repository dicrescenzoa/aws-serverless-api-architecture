import {FastifyInstance, FastifyPluginOptions} from 'fastify'

const routes = (server: FastifyInstance, _: FastifyPluginOptions, done: () => void) => {

    server.get('/', async () => {
        return 'Hello from /\n'
    })

    server.get('/ping', async () => {
        return 'pong\n'
    })

    server.get('/ping2', async () => {
        return 'pong2\n'
    })

    done();
}

export default routes