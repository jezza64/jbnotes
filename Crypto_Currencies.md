# Crypto Currencies

## Coins

### Polka Dot

Fully open permissionless space. Paradigm for developers to develop their own smart contracts. Etherium standard contracts, Dot you can customise much more. Fork from Etherium by same people, better version of Ethereum 2.0. Launchpad for next generation of layer 1. Relay chains: central chain to link the multiple other chains. Build your own layer 1, link it to the Polka dat parachain to provide security.

Layer 0: Polka Dot. Because nothing built in, just a layer for security and transport.
Layer 1: Base layer of tech. Bitcoin, Etherium, Dot.
Layer 2: Add extra functions on top. Offload work from layer 1. e.g. extra data stored.

Originally was interoperability, because platform for all. But now it's a generic platform.

Binance smart chain is like a copy of Etherium with simpler nodes to reduce congestion. Quick play to get users. But how decentralised?

### Cardano (ADA)

non profit, smart contracts coming soon.
Etherium variant.
PoS.
Not loads of developers.
NFTs are on here.

### Litecoin

means cheap micro transaction on BTC
2 users set up a shared multisig wallet. Conduct unlimited number of small transactions, agree them both. These doesn't need storing on the blockchain. When close the channel, store on blockchain.
Not as secure so only ofr low value.

### Concordium

building business useful Blockchain.
Doing layer 1 blockchain, with API on top, and a smart contract language
They provide infrastructure, like Polkadot, but also have centralised features, e.g. allow regulators to inspect given a court order.
Covers proof of identity
high performance, quick transactions, shards.
Use case e.g. escrow when you want both transactions to happen at the same time - banks can do this but complex to arrange given cross border and KYC.
or e.g. vaccine passports - prove you have permissions for something but not give away all your data when you scan a QR code containing loads of things when you just want a litre of milk. SO they have a way for you to limit your data that you give out, just give controlled attributes from a trusted source.
Use identity providers to prove, then open accounts. Then can disclose to regulators via court order.
Not giving away equity with the coins.

training video https://www.youtube.com/watch?v=7HDH7l94rFM
interview: https://www.realvision.com/shows/the-interview-crypto/videos/concordium-spearheading-business-adoption-of-blockchain

## Stable coins

small market cap are more volatile, affected by buy / sell.
Other benefits are defi structures.
get the transportability and convenience of crypto with the stability of Fiat.
Payment still hard. Used lots on crypto exchanges. Exchange BTC for USDT to reduce risk.
Move between exchanges easily, good for arbitrage.
Good for utility.

To maintain a peg:

1. create trust with collateral. USDT (Tether) backed by actual USD. DSG backed by gold. Or back with crypto, that's easier to audit as it's visible on blockchain.
2. algorythmic peg. Write smart contract which increases / decreases supply based on price. No assets held, the smart contract is like a central bank.

collateralised issues:

- secure real world assets
- capital sits idle
- capital can be stolen
- hard to prove. e.g. Tether accused of insufficient collateral

algorithmic issues:

- easy to audit collateral
- crypto volatile, so need to be over collateralisied
- does the supply demand mechanism really work in distress?

Business model: fees for coins, marketing, etc. e.g .coinbase have one to get users.

- USDT Tether: Fiat collateralised pegged to USD
- TUSD True USD: Fiat collateralised, bank accounts audited
- GUSD: Gemini. Fiat collateralised, regulated.
- USDC: issued by Coinbase / Circle. Fiat collateralised.
- DAI: crypto collateralised.

will peg work? All fail due to cost of maintaining them. e.g. Gold standard.
Governance: they are basically centralised as controlled by a company.
Is there a real problem to solve with stable coins? Vol of BTC will calm down so not needed.
Regulation may come in.
So stable coins could be short term.

## Usage

### Earning bitcoin

faucet: sell advertising, pay people to click.
signature: campaign: get paid for posting.
trading: time and capital
affiliate program: e.g. sign up others to exchanges from your media.
gambling: casinos. Is it provably fair?
blogging: look at Upwork for freelance marketplace
mining: expensive low margin
lending: collateral at risk. All default eventually! Don't do this.

### Bitcoin loans

main ones are nexo, blockfi, unchained capital, bitbond
You hodler has best rates,

generally about 50% LTV
APR varies, was 6% to 16%

Lending: deposit BTC, get FIAT as a loan. Means defer tax on sale. No credit checks as fully collateralised.

Can also deposit BTC for interest.

Margin calls
Fees about 2%
some companies rehypothecthize your crypto so it's a credit risk.

unchained capital do a multisig where you have some control over the ownership still.

- Are loans collateral backed? This is crucial if you’re an investor.
- Loan terms (APV, LTV, payment schedule)
- Collateral holding (multisig vs. custodial vs. in the company’s wallet)
- Does the company use user funds for additional investments?

### You hodler deposits

BTC pays 4.8%
min 0.1 BTC
instant access
not clear on collateral pledge

### P2P exchanges

Just offer and match.
Escrow to hold funds during transfer
Less KYC than on exchanges
e.g. Paxful, Localbitcoins, Binance P2P, HODL HODL

charge e.g. 1% for sellers, 0 for buyers

### Centralised exchanges

#### Coinbase

35m customers, 100 countries.
it's an exchange not a wallet, so you don't have access to your private keys.
credit or debit card payments - these can be delayed while checked for fraud
Card purchases on coinbase are 4% - only 1.5% for transfers.
Coinbase pro is lower fees - not 1.5%, pay 0.5% for < $10K.

#### Gemini

winkelvoss
advanced platform Active trader fees are 0.35%

#### Kraken

Low fees, secure.
0.25% fees in advanced

#### Crypto.com

more expensive
Have a debit card

#### Binance

Mainly crypro to crypto, cheap
Binance jersey is dead
Lots of cryptos, big range, 0.1%

#### etoto

User friendly. CFDs dep on regulations.
copy other traders
long delays if pay with card.
Higher fees.

### Wallets

wallet stores and manages the functions for the private key.
Seed is string of common words that can be used to reconstruct the private key,
Can create many addresses from the same seed, all for the same wallet.
Keep private key and seed safe.

Wallets can use full node or just recent nodes

wallet types:

Hot wallets at exchanges:
dont have access to your private keys
less secure

desktop wallets:
store on PC (Exodus is best).

Mobile phone:
insecure, not private, phones broken

Cold wallet:
independent of internet connection
need to keep the dongle with you to send stuff,

Have multiple wallets, one for small transactions.

If you had $50,000, you wouldn't keep it all in your wallet. So why should your BTC be any different?

Using more than one Bitcoin address — meaning your cryptocurrency isn't in one place — can be a smart move.

### how wallets work

https://medium.com/tradecloud/crypto-wallets-and-addresses-1-d874c75ebe11

## Mechanisms

### Asymetric key encryption

multiply 2 numbers is easy, to find the factors is hard.

Asymetric keys:
public key used to encrypt, private can decrypt.
So share the public, sender encrypts with it, decrypt with the private.
Can encrypt with either public or private

private key is for you to give authorisation (or verification). Never send private key. public key derived from the private key, can be sent over the internet, used to decrypt. Can't get from the public key to the private key.

message plus private key gives a message signature. send this message and signature to someone else. Recipient has the public key. Can use the public key to verify that the message was signed with the private key. The public key is the account id.

Algorithm to generate keys can be

- RSA (3 names)
- ECC: elliptical curve (elliptical curve: cubic terms, that gives one of the numbers). Used by Bitcoin, etherium.
- DSA digital signature algorithm
e.g. SSL uses 2048 bit RSA keys.

Asymetric key pair gives security of message and identity of sender.

Security of message

- sender: looks up the public key of the recipient, encrypts a message with it
- recipient uses their private key to decrypt it.

Identity proof

- sender uses private key to encrypt a message,
- recipient (or anyone) and use the senders public key to decrypt it. If you can decrypt with th public key, it must have come from teh private key, so identity proved.
- transmission not secure but proof of origin.

Quantum compute is a threat.

### blockchain

Blockchains are p2p, open source, public.
Consensus mechanisms protect from cyber attacks.
Lots of copies so no points of failure..
POW: nee 51% of nodes to agree a change to blockchain,
Transaction = block. Lots of blocks in a blockchain, Record of movements.
past blocks are inflexible, unless 51% of people agree which is an unlikely scam.

demo at https://blockchaindemo.io/

### Blockchain with Condordia

Rust programing language.
Another blockchain..

### Proof of Work

Needs multiple consensus to add to blockchain
every 10 mins
rewards in BTC - halvings half rewards, about every 4 years.
Used by BTC, Litecoin, etc

### Proof of stake

Deposit funds on a node as a stake. Contest to forge the next block. Winner chosen based on stake, time of stake, plus random. This means it's hard to take control.
e.g. Cardano.

ETH was POW until 2020. ETH 2.0 is POS.
Need to lock up 32 ether as collateral on each node.
Soon Eth 2.0 will merge with ETH 1.0, 2022 - the docking. Then just POS
only get staking rewards after docking.
For Eth 2.0, each validator gets a share of the next block. Pie reduces as more validators. Staking calculators.
Signing up hard: only 900 new validators per day. 20K validators waiting now.
Needs dedicated computer with online connection. Can be penalties for problems.
Alternative simpler staking solutions: e.g. some exchanges can do it for you. But need to let exchange control the coins.
Staking pool: group doing the staking. reduces minimum stake. But is it reliable, customer support, user reviews, collateral etc.
Validator as a service: rent a validator, your stake. easy to do but get control.

Staking on Exchanges

- Coinbase - http://bit.ly/35bKkSJ​
- Binance - http://bit.ly/3b86vgq​
- Cex - http://bit.ly/3b6ofZJ​
- Kraken - https://bit.ly/3hKhIVF​

Staking through Wallets

- Atomic Wallet: http://bit.ly/38XGk9D​
- Guarda Wallet: https://bit.ly/389JIis​

Staking Pools

- Rocket Pool - https://bit.ly/3nbYNV4​

Validator as a Service

- Staked.US - http://bit.ly/2MywO5d

### Tokenisation

Take a non fungible thing, tokenise, then can sell a part of it or exchange temporarily.
E.g. part of a house, time, art, book rights etc
There's an art to making the incentives right to get the network to prosper.
But it's hard to get completely correct: e.g. extra transaction fees on ETH when it's busy, result in movement away for lower value transactions onto cheaper networks, reduce liquidity, mean it dies.
Anish Mohammed talk on real vision.

## Defi

### Overview

Can build e.g. exchanges which are not controllled by aynone

Etherium a good platform for smart contracts. Write decentralised applications (DAPS)
set the rules in the code, then you don't control the rules once published.
need to start with some money. ETH is volatile, so generally use stablecoins (pegged to e.g. USD).
You don't want to have directly cash backed stablecoin as then you can't decentralise
DAI is an example of a stablecoin pegged to USD, overcollateralised with crypto asset basket. Decentralised because doens't need Fiat currency. Deposit $1 ETH, get. $0.66 Dai. Or buy DAI. Overcollateraliseation covers for ETH volatility. So it's decentralised, secure.

Serives

- decentralised exchange (DEX). Rules to buy / sell. No central exchange operator, no identity, no fees. Just smart contracts. Don't need to deposit funds, just exchange directly.
- decentralised money markets. e.g. uniswap. Connect borrowers and lenders. e.g. Compond. Deposit crypto, borrow against it with a smart contract. (yield farming).
- decentralised insurance. people willing to buy insurance vs sellers. Mix and match services.

Money legos to build services. put services together.

advantages:
transparency
interoperability
decentralisation
free
flexable

problems:
infancy
smart contracts could be hacked
some partially centralised services can be compromised
hard to understand

examples: https://defipulse.com/defi-list/

### Another explanation

Use Etherium, good for writing decentralised apps.
Write smart contracts to manage the financial service. Deploy rules on Etherium network, can't change them.
Bitcoin has only basic programmable functionality.
Stable coins: crypto but pegged to a stable fiat currency USD.
So use Etherium based on USD
DAI is a stablecoin, decentralised, over collateralised. Platform for lots of DeFi.

DEX: decentralized exchange.
No signups, fees, et.c Just smart contracts.
Don't need to put money there first, a direct transfer.

Everything happens autonomously, no intermediaries. Open source.

Lots of advantages: decentralised, cheap, automated etc
Risks: in infancy, so things can go wrong.

## Defi DAPPS

### news

DAPP radar

### uniswap

decentralised exchange aggregator and liquidity increaser
does ETH to USDC, but only has wrapped bitcoin.
Better trading terms I think.
Most volume in ETH
argument that this value should increase as coinbase gets clearer value

UNI are governance tokens, you can vote, plus get a share of the fees
Should be valuable.
Uniswap is open source. You provide liquidity and get rewarded.
Looks good technically.

## Integration

### how to get pricing functions in google sheets

https://medium.com/coinmonks/how-to-value-your-stocks-crypto-portfolio-in-google-sheets-22bb7b42c39d
