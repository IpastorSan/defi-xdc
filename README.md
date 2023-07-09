# ERC4626 Vault Standard and ERC6551 Token Bound Account for standardized DeFi integration.

## Objectives
1. Show how the ERC4626 standard can be used to integrate different Defi protocols under a common interface.
2. How we can group together portfolios of yield-bearing assets into a Token Bound Account. This is useful to group different tokens with various APR and risk profiles into a single tradable entity.

## Completed:

### Phase 1
**Objective** 
To deploy all the primitives needed for the project and show a basic workflow

1. Deployment of 2 XRC20 tokens: token0 and token1 for the different integrations.
2. Deployment of Naive Linear Rewards Strategy, that generates 1 wei per second per wei staked. This is used to show the simlest of integrations with an ERC4626 Vault.
3. Deployment of ERC4626 Vault integrating Naive Linear strategy (LinearRewardsVault.sol). This vault is able to receive token0 from the user and send it to the naive "protocol" in order to start generating yield. It generates back stToken1, which represent fractional ownership of the underlying Vault assets.
4. Deployment of ERC6551 Canonical registry. This smart contract is the reference one for generating Token Bound Accounts in a given EVM.
5. Deployment of a Smart Wallet implementation to generate the Account bound to an ERC721.
6. Deployment of ERC721Portfolio NFT contract. Each token ID acts as a "key" to the token bound account. Each tokenId can only have 1 associated implementation of an Account, but also can be linked to different implementations.
7. Contract interaction to show the interaction between a Token Bound Account and the LinearRewardsVault [tx Hash](https://explorer.xinfin.network/txs/0x9cbd8ad09d1f2592def22e7384c074fd89ce87027e76c70a246e59838e6ed3e4#overview)

### Phase 2
**Objective**
Deploy a more complex yield bearing protocol with additional utility. The selected protocol was the UniswapV3 DEX. The commercial License of the protocol expired in April, 2023 so it can be used as-is.

1. Deployment of the set of contracts that make up UniswapV3
2. Deployment of a liquidity pool (token0/token1)

## Not completed (next Steps)
### Phase 2
3. Deployment of ERC4626 and UniswapV3 integration. The design will follow this [example](https://github.com/superform-xyz/super-vaults/tree/main/src/uniswap-v2) but adapted to V3. A user will input token0 to the vault, it will get divided into token1 and token0 and then deposited to generate liquidity (NFT position). References to implement it [here, Liquidity Example](https://github.com/Uniswap/docs/blob/main/examples/smart-contracts/LiquidityExamples.sol) and [here, Swap Example](https://github.com/Uniswap/docs/blob/main/examples/smart-contracts/SwapExamples.sol)

## Phase 3
1. Deployment of a Frontend that will guide the user through the whole process: 
    - 1) Minting a Portfolio NFT and generating a token Bound account
    - 2) Selecting an ERC4626 Vault and investing in it through their TBA
    - 3) Cloning of Uniswap FE implementation to make the DEX usable.

## Repository Structure
1. `eth-xdc` contains all the smart contracts described above, except the UniswapV3 ones. It is a Foundry project ready with deployment scripts.
2. `deploy-v3` contains a CLI to deploy the set of Uniswap V3 contracts in any EVM compatible chain. Forked from the Uniswap org, slightly modified for compilation and running.
3. `calculate-sqrtPriceX96`. Simple script to calculate the initial relative price of a token pair, for UniswapV3 liquidity pool creation.

## Smart contracts

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
- Token Bound Account for NFT with id 1: 0x4593a4A38330d23C751Ef3479febf33f30DC2391

## Foundry Project

## Deploy locally to Anvil
Adapt the command to the script that you want to run. Be sure to have the correct addresses in your `.env` file

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