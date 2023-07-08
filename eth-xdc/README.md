# Smart contracts

## Deploy locally to Anvil

- Run `anvil`
- get one of the 10 default private keys that it gives you. Store it in an `.env`file and run `source .env`in your Bash terminal.
- Run `forge script script/Deploy.s.sol:Deploy --fork-url http://localhost:8545  --private-key $PRIVATE_KEY_ANVIL --broadcast` 


## Deploy to any network
- Store your Private Key, Etherscan key for verification and RPC URL in an `.env`file and run `source .env`in your Bash terminal.
- Run `forge script script/Deploy.s.sol:Deploy --rpc-url $XDC_RPC_TEST  --private-key $PRIVATE_KEY --broadcast --verify --etherscan-api-key $ETHERSCAN_KEY -vvvv`

## Run Foundry tests
Easy, run `forge test -vvvv`