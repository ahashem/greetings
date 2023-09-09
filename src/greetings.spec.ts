import {greeting} from './greetings';

describe('greetings', () => {
    it('should return statusCode 200', async () => {
        const response = await greeting();
        expect(response.statusCode).toEqual(200);
    });
    it('should return body Hello World!', async () => {
        const response = await greeting();
        expect(response.body).toEqual('Hello World!');
    });
});
