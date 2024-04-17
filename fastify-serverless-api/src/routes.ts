import {FastifyInstance, FastifyPluginOptions} from 'fastify'

const routes = (server: FastifyInstance, _: FastifyPluginOptions, done: () => void) => {

    server.get('/', async () => {
        return 'Hello from fastify-serverless-api\n'
    })

    server.get('/ping', async () => {
        return 'pong\n'
    })

    server.register(usersRoutes, {prefix: "/users"})

    done();
}

const usersRoutes = (server: FastifyInstance, _: FastifyPluginOptions, done: () => void) => {
    server.get<{
        Params: { id: string }
        Reply: { id: string, name: string }
    }>('/:id/profile', async (request, reply) => {
        const {id} = request.params;
        reply.code(200).send({id, name: 'Alice'})

        return;
    })

    server.get<{
        Params: { id: string }
        Reply: { id: string, bgColor: string }
    }>('/:id/settings', async (request, reply) => {
        const {id} = request.params;
        reply.code(200).send({id, bgColor: 'red'})
        return;
    })

    done();
}

export default routes