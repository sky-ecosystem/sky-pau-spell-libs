// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.34;

interface IPSM3Facet {

    function VERSION() external pure returns (string memory);

    function psm() external view returns (address);

    function deposit(address asset, uint256 amount) external returns (uint256 shares);

    function withdraw(address asset, uint256 maxAmount) external returns (uint256 assetsWithdrawn);

    function getDepositRateLimitKey(address asset) external pure returns (bytes32 key);

    function getWithdrawRateLimitKey(address asset) external pure returns (bytes32 key);

}

interface IPSM3Controller {

    function psm3_VERSION() external pure returns (string memory);

    function psm3_psm() external view returns (address);

    function psm3_deposit(address asset, uint256 amount) external returns (uint256 shares);

    function psm3_withdraw(address asset, uint256 maxAmount)
        external
        returns (uint256 assetsWithdrawn);

    function psm3_getDepositRateLimitKey(address asset) external pure returns (bytes32 key);

    function psm3_getWithdrawRateLimitKey(address asset) external pure returns (bytes32 key);

}
