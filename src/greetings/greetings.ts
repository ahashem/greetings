import middy from '@middy/core'

export async function greeting () {
    return {
        statusCode: 200,
        body: `Hello World!`
    }
}

let handler = middy(greeting)

export default handler