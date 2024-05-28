slither src/DexWithApprove.sol
'forge config --json' running
Could not detect solc version from Foundry config. Falling back to system version...
'solc --version' running
'solc @openzeppelin/contracts/=lib/openzeppelin-contracts/contracts/ ds-test/=lib/openzeppelin-contracts/lib/forge-std/lib/ds-test/src/ erc4626-tests/=lib/openzeppelin-contracts/lib/erc4626-tests/ forge-std/=lib/forge-std/src/ openzeppelin-contracts/=lib/openzeppelin-contracts/ src/DexWithApprove.sol --combined-json abi,ast,bin,bin-runtime,srcmap,srcmap-runtime,userdoc,devdoc,hashes --optimize --optimize-runs 200 --evm-version shanghai --allow-paths .,/Users/guesttrue/Desktop/LunarX/src' running
INFO:Detectors:
Dex.constructor(address,address,address,address)._vestingAddress (src/DexWithApprove.sol#36) lacks a zero-check on :
                - vestingAddress = _vestingAddress (src/DexWithApprove.sol#43)
Vesting.setDexAddress(address)._dexAddress (src/Vesting.sol#83) lacks a zero-check on :
                - dexAddress = _dexAddress (src/Vesting.sol#84)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation
INFO:Detectors:
Vesting.lock(uint256,address) (src/Vesting.sol#37-52) uses timestamp for comparisons
        Dangerous comparisons:
        - require(bool,string)(block.timestamp < commonExpiry,Tokens have been unlocked) (src/Vesting.sol#41)
Vesting.withdraw() (src/Vesting.sol#54-67) uses timestamp for comparisons
        Dangerous comparisons:
        - require(bool,string)(block.timestamp > commonExpiry,Tokens have not been unlocked) (src/Vesting.sol#56-59)
Vesting.getDifferenceTime() (src/Vesting.sol#87-92) uses timestamp for comparisons
        Dangerous comparisons:
        - block.timestamp >= commonExpiry (src/Vesting.sol#88)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#block-timestamp
INFO:Detectors:
Address._revert(bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#146-158) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Address.sol#151-154)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
INFO:Detectors:
Different versions of Solidity are used:
        - Version used: ['0.8.24', '^0.8.20']
        - 0.8.24 (src/DexWithApprove.sol#2)
        - 0.8.24 (src/Vesting.sol#2)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Pausable.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol#4)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
Address.functionDelegateCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#104-107) is never used and should be removed
Address.functionStaticCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#95-98) is never used and should be removed
Address.sendValue(address,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#41-50) is never used and should be removed
Address.verifyCallResult(bool,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#135-141) is never used and should be removed
Context._contextSuffixLength() (lib/openzeppelin-contracts/contracts/utils/Context.sol#25-27) is never used and should be removed
Context._msgData() (lib/openzeppelin-contracts/contracts/utils/Context.sol#21-23) is never used and should be removed
ReentrancyGuard._reentrancyGuardEntered() (lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol#81-83) is never used and should be removed
SafeERC20._callOptionalReturnBool(IERC20,bytes) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#110-117) is never used and should be removed
SafeERC20.forceApprove(IERC20,address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#76-83) is never used and should be removed
SafeERC20.safeDecreaseAllowance(IERC20,address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#61-69) is never used and should be removed
SafeERC20.safeIncreaseAllowance(IERC20,address,uint256) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#52-55) is never used and should be removed
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#dead-code
INFO:Detectors:
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Pausable.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.24 (src/DexWithApprove.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.24 (src/Vesting.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
solc-0.8.24 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
Low level call in SafeERC20._callOptionalReturnBool(IERC20,bytes) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#110-117):
        - (success,returndata) = address(token).call(data) (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#115)
Low level call in Address.sendValue(address,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#41-50):
        - (success) = recipient.call{value: amount}() (lib/openzeppelin-contracts/contracts/utils/Address.sol#46)
Low level call in Address.functionCallWithValue(address,bytes,uint256) (lib/openzeppelin-contracts/contracts/utils/Address.sol#83-89):
        - (success,returndata) = target.call{value: value}(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#87)
Low level call in Address.functionStaticCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#95-98):
        - (success,returndata) = target.staticcall(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#96)
Low level call in Address.functionDelegateCall(address,bytes) (lib/openzeppelin-contracts/contracts/utils/Address.sol#104-107):
        - (success,returndata) = target.delegatecall(data) (lib/openzeppelin-contracts/contracts/utils/Address.sol#105)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#low-level-calls
INFO:Detectors:
Function IERC20Permit.DOMAIN_SEPARATOR() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#89) is not in mixedCase
Parameter Dex.depositUSDTandReciveToken(uint256)._amount (src/DexWithApprove.sol#48) is not in mixedCase
Parameter Dex.getBalance(address)._tokenAddress (src/DexWithApprove.sol#80) is not in mixedCase
Parameter Dex.withdraw(address)._tokenAddress (src/DexWithApprove.sol#84) is not in mixedCase
Constant Dex.tokenX_PRICE_IN_USDT (src/DexWithApprove.sol#22) is not in UPPER_CASE_WITH_UNDERSCORES
Parameter Vesting.lock(uint256,address)._amount (src/Vesting.sol#38) is not in mixedCase
Parameter Vesting.lock(uint256,address)._beneficiary (src/Vesting.sol#39) is not in mixedCase
Parameter Vesting.getBeneficiaryAmount(address)._beneficiary (src/Vesting.sol#74) is not in mixedCase
Parameter Vesting.getSupply(address)._tokenAddress (src/Vesting.sol#79) is not in mixedCase
Parameter Vesting.setDexAddress(address)._dexAddress (src/Vesting.sol#83) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
Dex.vestingContract (src/DexWithApprove.sol#20) should be immutable 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable
INFO:Slither:src/DexWithApprove.sol analyzed (10 contracts with 94 detectors), 45 result(s) found
