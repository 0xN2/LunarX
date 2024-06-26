// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import "./Vesting.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/IERC20Permit.sol";

// TODO
// cliff or delay to start, or setter method after deploy

contract Dex is ReentrancyGuard, Pausable, Ownable {
    IERC20 private immutable tokenX;

    IERC20 private immutable usdt;
    IERC20Permit private immutable usdtPermit;

    address private immutable vestingAddress;

    Vesting private vestingContract;

    uint256 private constant tokenX_PRICE_IN_USDT = 100;

    // keeps track of individuals' tokenX balances
    mapping(address => uint256) public tokenXBalances;

    // keeps track of individuals' USDC balances
    mapping(address => uint256) public usdtBalances;

    event dexDeposit(
        address indexed beneficiary,
        uint256 indexed amount,
        uint256 indexed tokenToReceive
    );
    /// @dev tokens ERC20
    // @param tokenX token to delivery, ERC20 with 18 decimals
    // @param usdT ERC20 with 6 decimals

    constructor(
        address initialOwner,
        address _vestingAddress,
        address _tokenX,
        address _tokenUsdt
    ) Ownable(initialOwner) {
        tokenX = IERC20(_tokenX);
        usdt = IERC20(_tokenUsdt);
        usdtPermit = IERC20Permit(_tokenUsdt);
        vestingAddress = _vestingAddress;
        vestingContract = Vesting(vestingAddress);
    }

    function depositUSDTandReciveToken(
        uint256 _amount,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) public nonReentrant whenNotPaused {
        /// -------------------------------------------------------------------
        /// PermitSignature
        /// -------------------------------------------------------------------
        IERC20Permit(usdtPermit).permit(
            msg.sender,
            address(this),
            _amount,
            deadline,
            v,
            r,
            s
        );

        /// -------------------------------------------------------------------
        /// Checks
        /// -------------------------------------------------------------------
        uint256 allowance = usdt.allowance(msg.sender, address(this));
        require(allowance >= _amount, "Check the token allowance");

        /// -------------------------------------------------------------------
        /// Effects
        /// -------------------------------------------------------------------
        usdtBalances[msg.sender] += _amount;

        /// -------------------------------------------------------------------
        /// Interactions
        /// -------------------------------------------------------------------
        SafeERC20.safeTransferFrom(usdt, msg.sender, address(this), _amount);

        uint256 tokenToReceive = ((usdtBalances[msg.sender] *
            tokenX_PRICE_IN_USDT) * 1e12);

        SafeERC20.safeTransfer(
            tokenX,
            address(vestingContract),
            tokenToReceive
        );

        vestingContract.lock(tokenToReceive, msg.sender);

        emit dexDeposit(msg.sender, _amount, tokenToReceive);
    }

    function getBalance(address _tokenAddress) public view returns (uint256) {
        return IERC20(_tokenAddress).balanceOf(address(this));
    }

    function withdraw(address _tokenAddress) public onlyOwner {
        IERC20 token = IERC20(_tokenAddress);

        SafeERC20.safeTransfer(
            token,
            msg.sender,
            token.balanceOf(address(this))
        );
    }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }
}
