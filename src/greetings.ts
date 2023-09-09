import middy from '@middy/core'

async function lambdaHandler () {
    return {
        statusCode: 200,
        body: `Hello World!`
    }
}

let handler = middy(lambdaHandler)

export default handler