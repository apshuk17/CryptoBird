const assert = require('chai').assert;

const KryptoBird = artifacts.require('KryptoBird');

// check for chai
require('chai')
.use(require('chai-as-promised'))
.should()

contract('KryptoBird', accounts => {
    let contract;

    // testing container
    describe('deployment', () => {
        beforeEach(async () => {
            contract = await KryptoBird.deployed();
        });

        it('deploys successfuly', async () => {
            const address = contract.address;
            console.log('##address', address);
            assert.notEqual(address, '');
            assert.notEqual(address, null);
            assert.notEqual(address, undefined);
            assert.notEqual(address, 0x0);
        });

        it('should match name and symbol', async () => {
            const name = await contract.name();
            const symbol = await contract.symbol();

            assert.equal(name, 'Kryptobird');
            assert.equal(symbol, 'KBIRDZ');
        });
    });
});