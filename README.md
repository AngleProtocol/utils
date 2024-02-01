## Utils

The utils repository is used to store utils contracts and libraries that are used across multiple solidity projects. It is meant to be used as a submodule in other projects.

## Installation

```bash
forge install https://github.com/AngleProtocol/utils
```

## Setup

After installing you need to create a javascript file un utils named *forwardUtils.js* with the following content:

```javascript
const { exec } = require("child_process");

if (process.argv.length < 3) {
    console.error('Please provide a chain input as an argument.');
    process.exit(1);
}

const command = process.argv[2];
const extraArgs = process.argv.slice(3).join(' ');


exec(`node lib/utils/utils/${command}.js ${extraArgs}`, (error, stdout, stderr) => {
    if (error) {
        console.log(error);
        return;
    }
    if (stderr) {
        console.log(stderr);
        return;
    }
    console.log(stdout);
});
```

