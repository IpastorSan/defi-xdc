# Smart contracts

## Xinfin Addresses
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
- token0: 0x5AC3B12D0e70ffcdc0dB1D6Fb4aB4CAF11759Bc3
- token1: 0xa49E3c2d28bD09A2369b585fD24d3aC1ad943201

### token0/token1 Pool
- token0/token1 pool: 0x3C999d936EF84c035d883563cE5f294a0524f459

## Naive Yield Bearing protocol and ERC4626 Vault
- LinearStaking: 0x46b390A66781E650240a6c97eC96b96e99003084
- LinearRewardsVault: 0xbB57468708a46e4EcE063Ea869AaDFE82aE4C62e

## Token Bound Accounts (ERC6551) that represent portfolios of Assets
- PortfolioNFT: 0x2F8fF9B87AEDc1f1DbB9d7C8F1F0451B168a869B
- ERC6551 Canonical Registry: 0x455990C9651D478B027489b49C943283575083e7
- Token Bound account Implementation: 0x67B18210fc6C25200413c91E55199a3BB8e5c3D4
- Token Bound Account for NFT with id 2: 0x4593a4A38330d23C751Ef3479febf33f30DC2391


## Deploy locally to Anvil

- Run `anvil`
- get one of the 10 default private keys that it gives you. Store it in an `.env`file and run `source .env`in your Bash terminal.
- Run `forge script script/Deploy.s.sol:Deploy --fork-url http://localhost:8545  --private-key $PRIVATE_KEY_ANVIL --broadcast` 

## Deploy Locally to Anvil forking Xinfin with existing addresses.
- Run `forge script script/Deploy.s.sol:Deploy --fork-url $XDC_RPC  --private-key $PRIVATE_KEY --broadcast --legacy` 

## Deploy to Apothem
- Store your Private Key, Etherscan key for verification and RPC URL in an `.env`file and run `source .env`in your Bash terminal.
- Run `forge script script/Deploy.s.sol:Deploy --rpc-url $XDC_RPC_TEST  --private-key $PRIVATE_KEY --broadcast --legacy -vvvv`

## Deploy to Xinfin
- Store your Private Key, Etherscan key for verification and RPC URL in an `.env`file and run `source .env`in your Bash terminal.
- Run `forge script script/Deploy.s.sol:Deploy --rpc-url $XDC_RPC  --private-key $PRIVATE_KEY --broadcast --legacy -vvvv`

## Run Foundry tests
Easy, run `forge test -vvvv`