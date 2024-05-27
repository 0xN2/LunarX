# DEX and Vesting Smart Contracts

This project implements a decentralized exchange (DEX) and a vesting contract where users can swap USDT for a specific token (TokenX) and vest the tokens for a certain period before they can withdraw them. The exchange rate is 1 USDT = 100 TokenX.

## Overview

### DEX Contract

The DEX contract allows users to:
1. Deposit USDT and receive TokenX at a fixed rate.
2. Transfer TokenX to a vesting contract where it will be locked until a specified vesting period expires.

### Vesting Contract

The vesting contract:
1. Locks the tokens received from the DEX contract.
2. Allows users to withdraw their vested tokens after the vesting period has expired.

### Usage

1. Deploy the Vesting contract with the token address, expiry duration, and owner address.
2. Deploy the Dex contract with the owner address, vesting contract address, tokenX address, and USDT/USDC address.
3. Set the DEX address in the Vesting contract using the setDexAddress method.
4. Depositing USDT and Receiving TokenX
5. Users can deposit USDT and receive TokenX by calling the depositUSDTandReceiveToken function in the DEX contract. The received tokens will be transferred to the vesting contract and locked until the  vesting period expires.

6. Withdrawing Vested Tokens
After the vesting period has expired, users can withdraw their vested tokens by calling the withdraw function in the Vesting contract.


### Security Considerations

Use the nonReentrant modifier to prevent reentrancy attacks.
The contracts implement pausability to allow emergency stops.
Emergency Withdrawal
Slither Report: [text](Slither-Report.md)

### License

This project is licensed under the MIT License.



## Dex https://polygonscan.com/address/0x22DAcCD029c443D1af422f10dabcFB77EB69319f#readContract

## Vesting https://polygonscan.com/address/0xf609E9E0A5de65ECc06a00767304545afF59B770#readContract

## LunarX https://polygonscan.com/address/0xFF5570d4440aA0380D4ceA8F73A6027C3ce702C6

## USDC https://polygonscan.com/token/0x3c499c542cef5e3811e1192ce70d8cc03d5c3359


![alt text](<Screenshot 2024-05-14 at 8.35.31 AM.png>)

Echidna: ![alt text](<Screenshot 2024-05-24 at 10.32.35 AM.png>)


## Test Echidna
```
echidna test-echidna/dex.t.echidna.sol --contract EchidnaDexTest --config echidna-config.yaml 
```

```
echidna test-echidna/vesting.t.echidna.sol --contract EchidnaVestingTest --config echidna-config.yaml
```