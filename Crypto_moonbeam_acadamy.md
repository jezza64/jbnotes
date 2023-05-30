# Crypto Moonbeam academy, using polkadot and moonbeam

## intro

academy: https://academy.moonbeam.network/  
reference site: https://docs.moonbeam.network/
Remix, hardhat, truffle, ethers.js are all compatible with moonbeam.
login: jezza64, .uk email address, bj7

## Setup

Used metamask on chrome dev account
added moonbeam network to metamask
moonbeam account Dev1 0x43F6930f5fA42561C068aE589980634b04300a14

## Moonbeam background

Polkadot: 
- relay chain with parachains
- parachains are optimised for different applications
- rely chain passes messages between parachains
- moonbeam a parachain on polkadot, moonriver on Kusama
- shared security model. So parachains don't need to attract POS funds to validate. Parachains don't compete

Substrate:
- modular framework to build parachains
- can customise or bespoke dev for parachain

Moonbeam:
- Etherium compatible
- can use metamask
- aiming to be eay to migrate from Eth, BSC, polygon
- native on chain governance (not in Etherium)
- forkless upgrades (voted, automatic upgrades. Forkless, so no risk of 2 chains)
- interoperable with other Polkadot chains
- focussed on best ETH development experience
- Accounts are interoperable with Etherium and Polkadot. Most polkadot different addresses. Moonbeam has unified account structure, you can have a single address for Eth and Moonbeam.  

Why moonbeam:
- ecosystem of integrations
- services like the graph
- covalent for convenient account lookups
- block explorer https://moonscan.io/
- lots of tools

Eth compatability
- substrate has an EVM pallet
- frontier pallet provides state transition mapping. 

## Initial contract in Remix

https://remix.ethereum.org/  
Browser based files  
easiest to clone a github repository to a remix workspace  

For moonbean development enviornment, get a metamask wallet on moonbase alpha network. Faucet to get DEV eth in it.

using Metamask wallet, account G dev 3.

Remix: compile, then deploy to injected metamask provider.  

You can see teh contract on the blockchain at https://moonbase.moonscan.io/

public variables have an automatic getter

Moonbeam remix plugin just combines the compile and deploy tabs into one tab

## Open Zeppelin

see https://docs.openzeppelin.com/contracts/4.x/api/token/erc721#ERC721Enumerable
good for selecting code features.  
Thats a set of wizards to create code for what you need. Open source. Battle tested. boiler plate, audited.  
Interactive and modular.  

## Etherium contract types

ERC20: oldest, standard tokens like shares. Fungible, all tokens the same. Balance maintained in teh contract that says an address owns a certain balance.  

ERC721: standard NFT. each token unique. different traits, data, identifier. Each can be identified. 

ERC1155: combines best of both worlds. Previously 20 and 721s needed distinct contracts. 1155 allows you to share contracts between both. Tailores for teams issuing diffrent flavours of NFTs. e.g. launch iwth 10k NFTs. Now want new set of NFTs, different mint, different number of tokens: need different ERC721 contract. 1155 gets around this. Not just a wrapper for 721 or 20. But allows you to manage multiple groups of NFTS. 

## NFT features

Base URI: place to keep the data, e.g. IPFS or amazon. But no end date..
Mintable: can this be minted
Auto increment: yes
Burnable: yes
Pausable: privilaged accounts can suspecnd transfers
Enumerable: Allows on-chain enumeration of all tokens or those owned by an account. Increases gas cost of transfers. Query which are owned by each account
URI storage: allows URI to be updated. Exist for ever, so need to update locations.  
Access control: one account does everything or have multiple roles
Upgradability: immutible by default. Can have upgradable feature. 
Security contact, Licence

## NFT contract example

Select options in open zeppelin
load to remix
compile and deploy
transact to mint a couple to dev address
check they exist on etherscan

## Precompiled contracts

Substrate has additional features e.g. onchain governance
This is how to access these in moonbeam
Built into runtime, not actually a contract. But it has a contract address, and you call it like a contract. 
docs -> builders -> cononical contracts -> precompiled contracts. 
https://docs.moonbeam.network/builders/pallets-precompiles/precompiles/

e.g. staking example. 
stake glimmer in your app using these features  
Glimmer redomominated to 100 glimmer equiv to 1 Eth, so wei and gwei different scaling. 

## Truffle

simple installation. Works with moonbeam
https://docs.moonbeam.network/tutorials/eth-api/truffle-start-to-end/
Typically use moonbeam development node, then alpha testnet, then live.  
local moonbeam node is a node running on your machine, packages transactions into blocks with no 12 second delay.  

End point for moonbase alpha, provided by moonbeam: https://rpc.api.moonbase.moonbeam.network

Moonbeam truffle box provides boilerplate setup for moonbeam smart contract development. 

moonbeam truffle plugin for local development mnode, truffle verify plugin to verify smart contracts.  
Moonscan API key needed to verify accounts, create at https://moonscan.io/
API key token: X47KZ1V918IG63I4XX7PEAC8PFD7D31CFI

installed globally in conda jbblock env with >
`npm install -g truffle
mkdir moonbeam-truffle-box
truffle unbox PureStake/moonbeam-truffle-box'

commands: 

  Compile contracts:                     truffle compile
  Migrate contracts:                     truffle migrate
  Test contracts:                        truffle test
  Pull docker image development node:    truffle run moonbeam install
  Start development node:                truffle run moonbeam start
  Stop docker image development node:    truffle run moonbeam stop
  Pause development node:                truffle run moonbeam pause
  Unpause docker image development node: truffle run moonbeam unpause
  Get development node status:           truffle run moonbeam status
  Remove docker image development node:  truffle run moonbeam remove


