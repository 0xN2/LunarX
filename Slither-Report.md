INFO:Detectors:
Function IERC20Permit.DOMAIN_SEPARATOR() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#89) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
Function ERC20Permit.DOMAIN_SEPARATOR() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol#80-82) is not in mixedCase
Function EIP712._EIP712Name() (lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol#146-148) is not in mixedCase
Function EIP712._EIP712Version() (lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol#157-159) is not in mixedCase
Parameter Dex.depositUSDTandReciveToken(uint256,uint256,uint8,bytes32,bytes32)._amount (src/Dex.sol#50) is not in mixedCase
Parameter Dex.getBalance(address)._tokenAddress (src/Dex.sol#79) is not in mixedCase
Parameter Dex.withdraw(address)._tokenAddress (src/Dex.sol#83) is not in mixedCase
Constant Dex.tokenX_PRICE_IN_USDT (src/Dex.sol#24) is not in UPPER_CASE_WITH_UNDERSCORES
Parameter Vesting.lock(uint256,address)._amount (src/Vesting.sol#38) is not in mixedCase
Parameter Vesting.lock(uint256,address)._beneficiary (src/Vesting.sol#39) is not in mixedCase
Parameter Vesting.getBeneficiaryAmount(address)._beneficiary (src/Vesting.sol#74) is not in mixedCase
Parameter Vesting.getSupply(address)._tokenAddress (src/Vesting.sol#79) is not in mixedCase
Parameter Vesting.setDexAddress(address)._dexAddress (src/Vesting.sol#83) is not in mixedCase
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#conformance-to-solidity-naming-conventions
INFO:Detectors:
ShortStrings.slitherConstructorConstantVariables() (lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol#40-123) uses literals with too many digits:
        - FALLBACK_SENTINEL = 0x00000000000000000000000000000000000000000000000000000000000000FF (lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol#42)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#too-many-digits
INFO:Detectors:
Dex.vestingContract (src/Dex.sol#22) should be immutable 
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#state-variables-that-could-be-declared-immutable

INFO:Detectors:
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#169)
        - inverse = (3 * denominator) ^ 2 (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#184)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#169)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#188)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#169)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#189)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#169)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#190)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#169)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#191)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#169)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#192)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) performs a multiplication on the result of a division:
        - denominator = denominator / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#169)
        - inverse *= 2 - denominator * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#193)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) performs a multiplication on the result of a division:
        - prod0 = prod0 / twos (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#172)
        - result = prod0 * inverse (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#199)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#divide-before-multiply
INFO:Detectors:
Reentrancy in Dex.depositUSDTandReciveToken(uint256,uint256,uint8,bytes32,bytes32) (src/Dex.sol#49-77):
        External calls:
        - IERC20Permit(usdtPermit).permit(msg.sender,address(this),_amount,deadline,v,r,s) (src/Dex.sol#53-55)
        - SafeERC20.safeTransferFrom(usdt,msg.sender,address(this),_amount) (src/Dex.sol#61)
        State variables written after the call(s):
        - usdtBalances[msg.sender] -= _amount (src/Dex.sol#65)
        Dex.usdtBalances (src/Dex.sol#30) can be used in cross function reentrancies:
        - Dex.usdtBalances (src/Dex.sol#30)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#reentrancy-vulnerabilities-1
INFO:Detectors:
ERC20Permit.constructor(string).name (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol#39) shadows:
        - ERC20.name() (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#58-60) (function)
        - IERC20Metadata.name() (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#15) (function)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#local-variable-shadowing
INFO:Detectors:
Dex.constructor(address,address,address,address)._vestingAddress (src/Dex.sol#38) lacks a zero-check on :
                - vestingAddress = _vestingAddress (src/Dex.sol#45)
Vesting.setDexAddress(address)._dexAddress (src/Vesting.sol#83) lacks a zero-check on :
                - dexAddress = _dexAddress (src/Vesting.sol#84)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#missing-zero-address-validation
INFO:Detectors:
ERC20Permit.permit(address,address,uint256,uint256,uint8,bytes32,bytes32) (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol#44-67) uses timestamp for comparisons
        Dangerous comparisons:
        - block.timestamp > deadline (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol#53)
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
ShortStrings.toString(ShortString) (lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol#63-73) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol#68-71)
StorageSlot.getAddressSlot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#59-64) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#61-63)
StorageSlot.getBooleanSlot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#69-74) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#71-73)
StorageSlot.getBytes32Slot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#79-84) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#81-83)
StorageSlot.getUint256Slot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#89-94) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#91-93)
StorageSlot.getStringSlot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#99-104) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#101-103)
StorageSlot.getStringSlot(string) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#109-114) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#111-113)
StorageSlot.getBytesSlot(bytes32) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#119-124) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#121-123)
StorageSlot.getBytesSlot(bytes) (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#129-134) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#131-133)
Strings.toString(uint256) (lib/openzeppelin-contracts/contracts/utils/Strings.sol#24-44) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Strings.sol#30-32)
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/Strings.sol#36-38)
ECDSA.tryRecover(bytes32,bytes) (lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#56-73) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#64-68)
MessageHashUtils.toEthSignedMessageHash(bytes32) (lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#30-37) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#32-36)
MessageHashUtils.toTypedDataHash(bytes32,bytes32) (lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#76-85) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#78-84)
Math.mulDiv(uint256,uint256,uint256) (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#123-202) uses assembly
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#130-133)
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#154-161)
        - INLINE ASM (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#167-176)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#assembly-usage
INFO:Detectors:
Different versions of Solidity are used:
        - Version used: ['0.8.20', '^0.8.20']
        - 0.8.20 (src/GaslessTokenTransfer.sol#2)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#3)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
Different versions of Solidity are used:
        - Version used: ['0.8.24', '^0.8.20']
        - 0.8.24 (src/Dex.sol#2)
        - 0.8.24 (src/Vesting.sol#2)
        - 0.8.24 (src/tokenLunarX.sol#3)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#3)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Nonces.sol#3)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Pausable.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#5)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Strings.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#4)
        - ^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#4)
        - ^0.8.20 (src/tokenUsdt.sol#3)
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#different-pragma-directives-are-used
INFO:Detectors:
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/interfaces/draft-IERC6093.sol#3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Context.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.20 (src/GaslessTokenTransfer.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
solc-0.8.20 is not recommended for deployment
Reference: https://github.com/crytic/slither/wiki/Detector-Documentation#incorrect-versions-of-solidity
INFO:Detectors:
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/access/Ownable.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/interfaces/IERC5267.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Address.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Nonces.sol#3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Pausable.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/ReentrancyGuard.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/ShortStrings.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/StorageSlot.sol#5) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/Strings.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/cryptography/ECDSA.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/cryptography/EIP712.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/cryptography/MessageHashUtils.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/Math.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (lib/openzeppelin-contracts/contracts/utils/math/SignedMath.sol#4) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.24 (src/Dex.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.24 (src/Vesting.sol#2) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version0.8.24 (src/tokenLunarX.sol#3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
Pragma version^0.8.20 (src/tokenUsdt.sol#3) necessitates a version too recent to be trusted. Consider deploying with 0.8.18.
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

INFO:Slither:. analyzed (37 contracts with 94 detectors), 85 result(s) found