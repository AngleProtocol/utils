const { registry, ChainId } = require('@angleprotocol/sdk');

if (process.argv.length < 3) {
    console.log('Usage: node getConnectedChains.js <chainId>');
    process.exit(1);
}

const contract = process.argv[2];

// Try to parse the input as a number if possible
let contracts = [];
let chains = [];

for (const chain in ChainId) {
    switch (contract) {
        case 'EUR':
            if (registry(chain)?.EUR?.bridges?.LayerZero) {
                contracts.push(registry(chain)?.EUR?.bridges?.LayerZero);
                chains.push(chain);
            }
            break;
        case 'USD':
            if (registry(chain)?.USD?.bridges?.LayerZero) {
                contracts.push(registry(chain).USD.bridges?.LayerZero);
                chains.push(chain);
            }
            break;
        case 'ANGLE':
            if (registry(chain)?.bridges?.LayerZero) {
                contracts.push(registry(chain).bridges.LayerZero);
                chains.push(chain);
            }
            break;
    }
}

console.log(JSON.stringify({contracts, chains}));