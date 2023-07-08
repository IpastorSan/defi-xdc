# Smart contracts

## Apothem and Xinfin Addresses
### Uniswap
- UniswapV3Factory: 0x557f543ad8c7f8648B8Cadab1144cC8E9998CD6F
- UniswapInterfaceMulticall: 0x1a5f6afd9534c92d06E23500bA2ABAaeC711742C
- ProxyAdmin: 0xa8be49D9d9Dd0CeB73878444b2eb56d8e8E48fEa
- TransparentUpgradeableProxy: 0xc05273b5bF2bf7891268CB7A1203F3Dd9c8D9028
- TickLens: 0x32fa4898F3D335e39c3061811c13Af2886E83b8e
- Library NFT Descriptor: 0xad00bB1f9e3ceb61617e350669BD4E2652105084
- NonFungibleTokenPositionDescriptor: 0xFF90BedacbA9908cEA8cbFA654ACAC82E3cB141E
- NonFungiblePositionManager: 0x64022AFA8e39eA983BE5E047070Cb9Aeec36791f
- V3Migrator: 0x88aB1401cf5a1F22A89B08a3eF0FceC17fb28d5A
- UniswapV3Staker: 0xd0C4b9aB079bC459D83446F83A05d57a2C79bD47
- QuoterV2: 0x7ecB194e85EcEb0Cc932E8f83b369e8c74ed5a40
- SwapRouter02: 0x01bfBD067aFd3aD96aA2C82c3FB9E2DB7E4127C6

### Test XRC20 tokens
- token0: 
- token1:

### token0/token1 Pool
-token0/token1 pool: 

## Deploy locally to Anvil

- Run `anvil`
- get one of the 10 default private keys that it gives you. Store it in an `.env`file and run `source .env`in your Bash terminal.
- Run `forge script script/Deploy.s.sol:Deploy --fork-url http://localhost:8545  --private-key $PRIVATE_KEY_ANVIL --broadcast` 

## Deploy Locally to Anvil forking Xinfin
- Run `forge script script/Deploy.s.sol:Deploy --fork-url $XDC_RPC  --private-key $PRIVATE_KEY --broadcast` 

## Deploy to Apothem
- Store your Private Key, Etherscan key for verification and RPC URL in an `.env`file and run `source .env`in your Bash terminal.
- Run `forge script script/Deploy.s.sol:Deploy --rpc-url $XDC_RPC_TEST  --private-key $PRIVATE_KEY --broadcast -vvvv`

## Deploy to Xinfin
- Store your Private Key, Etherscan key for verification and RPC URL in an `.env`file and run `source .env`in your Bash terminal.
- Run `forge script script/Deploy.s.sol:Deploy --rpc-url $XDC_RPC  --private-key $PRIVATE_KEY --broadcast  -vvvv`

## Run Foundry tests
Easy, run `forge test -vvvv`